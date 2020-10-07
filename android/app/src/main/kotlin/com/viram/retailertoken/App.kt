package com.viram.retailetoken

 import io.flutter.app.FlutterApplication;
 import io.flutter.plugin.common.PluginRegistry;
 import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
 import com.viram.retailetoken.FirebaseCloudMessagingPluginRegistrant;
 import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

class App : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
    }
}