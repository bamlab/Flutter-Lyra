package tech.bam.flutter_payzen.android

import com.lyra.sdk.Lyra
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class FlutterPayzenPlugin : FlutterPlugin, PayzenApi.PayzenHostApi
{
  private var context: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        PayzenApi.PayzenHostApi.setup(flutterPluginBinding.binaryMessenger, this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        PayzenApi.PayzenHostApi.setup(binding.binaryMessenger, null)
    }

    override fun initialize(
        lyraKey: PayzenApi.LyraKeyInterface,
        result: PayzenApi.Result<PayzenApi.LyraKeyInterface>
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