package tech.bam.flutter_lyra.android

import com.lyra.sdk.Lyra
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class FlutterLyraPlugin : FlutterPlugin, LyraApi.LyraHostApi
{
  private var context: Context? = null

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
}