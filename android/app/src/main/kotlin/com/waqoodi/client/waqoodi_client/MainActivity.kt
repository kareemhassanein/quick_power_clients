package com.waqoodi.client.waqoodi_client
import androidx.core.view.WindowCompat //add this line

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onPostResume() {
        super.onPostResume()
        WindowCompat.setDecorFitsSystemWindows(window, false)
        window.navigationBarColor = 0 //for transparent nav bar
        window.statusBarColor = 0 //for transparent status bar
    }
}
