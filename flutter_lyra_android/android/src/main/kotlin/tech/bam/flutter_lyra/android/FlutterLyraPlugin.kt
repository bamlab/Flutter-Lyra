package tech.bam.flutter_lyra.android

import android.app.Activity
import android.content.Context
import androidx.fragment.app.FragmentActivity
import com.lyra.sdk.Lyra
import com.lyra.sdk.callback.LyraHandler
import com.lyra.sdk.callback.LyraResponse
import com.lyra.sdk.exception.LyraException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import kotlinx.coroutines.*
import java.util.concurrent.TimeUnit

class FlutterLyraPlugin : FlutterPlugin, ActivityAware, LyraHostApi
{
    private var context: Context? = null
    private var activity: Activity? = null

    private var lyraKey: LyraKeyInterface? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        LyraHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        LyraHostApi.setUp(binding.binaryMessenger, null)
        context = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.onAttachedToActivity(binding)
    }

    override fun initialize(
        lyraKey: LyraKeyInterface,
        callback: (Result<LyraKeyInterface>) -> Unit
    ) {
        val context = this.context

        if (context == null) {
            callback(Result.failure(Error("No android context attached to your application")))
            return
        }

        try {
            Lyra.initialize(
                context,
                lyraKey.publicKey,
                Converters.initializeOptionsFromInterface(lyraKey.options)
            )
            this.lyraKey = lyraKey
            callback(Result.success(lyraKey))
        } catch (error: Throwable) {
            callback(Result.failure(FlutterError(
                code = "initialization_error_code",
                message = error.message,
                details = null
            )))
        }
    }

    override fun getFormTokenVersion(callback: (Result<Long>) -> Unit) {
        if (lyraKey == null) {
            callback(Result.failure(FlutterError(
                code = "lyra_not_initialized_error_code",
                message = "You should initialize Lyra first",
                details = null
            )))
            return
        }
        val formTokenVersion = Lyra.getFormTokenVersion()

        callback(Result.success(formTokenVersion.toLong()))
    }

    override fun process(request: ProcessRequestInterface, callback: (Result<String>) -> Unit) {
        if (lyraKey == null) {
            callback(Result.failure(FlutterError(
                code = "lyra_not_initialized_error_code",
                message = "You should initialize Lyra first",
                details = null
            )))
            return
        }

        val flutterActivity = activity

        if (flutterActivity !is FragmentActivity) {
            callback(Result.failure(FlutterError(
                code = "fragment_activity_not_found_error_code",
                message = "Your activity should be or extend a FragmentActivity",
                details = null
            )))
            return
        }

        // If the request has a timeout argument, launch a timer that will call
        // Lyra.cancelProcess() after the given time.
        val timeout = request.timeoutInSeconds
        var cancelProcessJob: Job? = null

        if (timeout != null) {
            cancelProcessJob =  GlobalScope.launch {
                delay(TimeUnit.SECONDS.toMillis(timeout))
                Lyra.cancelProcess()
            }
        }

        try {
            Lyra.process(
                fragmentManager = flutterActivity.supportFragmentManager,
                formToken = request.formToken,
                lyraHandler = object : LyraHandler {
                    override fun onSuccess(lyraResponse: LyraResponse) {
                        cancelProcessJob?.cancel()
                        callback(Result.success(lyraResponse.toString()))
                    }

                    override fun onError(lyraException: LyraException, lyraResponse: LyraResponse?) {
                        cancelProcessJob?.cancel()
                        // We do not complete with error if errorCode is "MOB_013".
                        // This error indicate that the payment process cannot be cancelled.
                        // After this error, normal SDK behavior continues:
                        // if the payment completes successfully then the onSuccess handler will be called.
                        // if the payment is failed. Depending on the error, the payment form remains displayed or the onError handler will be called.
                        if(lyraException.errorCode != "MOB_013") {
                            callback(Result.failure(Converters.parseError(
                                lyraError = lyraException,
                                errorCodesInterface = request.errorCodes,
                                defaultFlutterError = FlutterError(
                                    code = "process_error_code",
                                    message = lyraException.message,
                                    details = null
                                )
                            )))
                        }
                    }
                },
                options = Converters.processOptionsFromInterface(request.options)
            )
        } catch (error: Throwable) {
            cancelProcessJob?.cancel()
            callback(Result.failure(FlutterError(
                code = "process_error_code",
                message = error.message,
                details = null
            )))
        }
    }
}