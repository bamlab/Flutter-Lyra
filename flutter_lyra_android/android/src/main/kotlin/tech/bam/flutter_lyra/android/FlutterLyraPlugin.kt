package tech.bam.flutter_lyra.android

import com.lyra.sdk.Lyra
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class FlutterLyraPlugin : FlutterPlugin, LyraApi.LyraHostApi
{
    private var context: Context? = null
    private var lyraKey: LyraApi.LyraKeyInterface? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        LyraApi.LyraHostApi.setup(flutterPluginBinding.binaryMessenger, this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        LyraApi.LyraHostApi.setup(binding.binaryMessenger, null)
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
}