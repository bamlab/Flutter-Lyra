package tech.bam.flutter_payzen.android

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin

class FlutterPayzenPlugin : FlutterPlugin, Info.InfosApi
{
  private var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Info.InfosApi.setup(flutterPluginBinding.binaryMessenger, this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Info.InfosApi.setup(binding.binaryMessenger, null)
    }

    override fun search(): Info.Infos {
        val info = Info.Infos()
        info.info1 = "info1"
        info.info2 = "info2"

        return info
    }
}