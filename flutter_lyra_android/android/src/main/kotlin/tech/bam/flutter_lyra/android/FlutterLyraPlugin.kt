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

class FlutterLyraPlugin : FlutterPlugin, ActivityAware, LyraApi.LyraHostApi
{
    private var context: Context? = null
    private var activity: Activity? = null

    private var lyraKey: LyraApi.LyraKeyInterface? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        LyraApi.LyraHostApi.setup(flutterPluginBinding.binaryMessenger, this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        LyraApi.LyraHostApi.setup(binding.binaryMessenger, null)
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
        lyraKey: LyraApi.LyraKeyInterface,
        result: LyraApi.Result<LyraApi.LyraKeyInterface>
    ) {
        val context = this.context

        if (context == null) {
            result.error(Error("No android context attached to your application"))
            return
        }

        try {
            Lyra.initialize(
                context,
                lyraKey.publicKey,
                Converters.initializeOptionsFromInterface(lyraKey.options)
            )
            this.lyraKey = lyraKey
            result.success(lyraKey)
        } catch (error: Throwable) {
            result.error(
                FlutterError(
                    code = "initialization_error_code",
                    message = error.message,
                    details = null
                )
            )
        }
    }

    override fun getFormTokenVersion(result: LyraApi.Result<Long>) {
        if (lyraKey == null) {
            result.error(
                FlutterError(
                    code = "lyra_not_initialized_error_code",
                    message = "You should initialize Lyra first",
                    details = null
                )
            )
            return
        }
        val formTokenVersion = Lyra.getFormTokenVersion()

        result.success(formTokenVersion.toLong())
    }

    override fun process(request: LyraApi.ProcessRequestInterface, result: LyraApi.Result<String>) {
        if (lyraKey == null) {
            result.error(
                FlutterError(
                    code = "lyra_not_initialized_error_code",
                    message = "You should initialize Lyra first",
                    details = null
                )
            )
            return
        }

        val flutterActivity = activity

        if (flutterActivity !is FragmentActivity) {
            result.error(
                FlutterError(
                    code = "fragment_activity_not_found_error_code",
                    message = "Your activity should be or extend a FragmentActivity",
                    details = null
                )
            )
            return
        }

        try {
            Lyra.process(
                fragmentManager = flutterActivity.supportFragmentManager,
                formToken = request.formToken,
                lyraHandler = object : LyraHandler {
                    override fun onSuccess(lyraResponse: LyraResponse) {
                        result.success(lyraResponse.toString())
                    }

                    override fun onError(lyraException: LyraException, lyraResponse: LyraResponse?) {
                        result.error(
                            Converters.parseError(
                                lyraError = lyraException,
                                errorCodesInterface = request.errorCodes,
                                defaultFlutterError = FlutterError(
                                    code = "process_error_code",
                                    message = lyraException.message,
                                    details = null
                                )
                            )
                        )
                    }
                }
            )
        } catch (error: Throwable) {
            result.error(
                FlutterError(
                    code = "process_error_code",
                    message = error.message,
                    details = null
                )
            )
        }
    }

    override fun cancelProcess(result: LyraApi.Result<Void>) {
        if (lyraKey == null) {
            result.error(
                    FlutterError(
                            code = "lyra_not_initialized_error_code",
                            message = "You should initialize Lyra first",
                            details = null
                    )
            )
            return
        }
        Lyra.cancelProcess()
        result.success(null)
    }
}