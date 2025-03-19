plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Firebase plugin
}

android {
    namespace = "com.example.student_nav_system"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"  // 🔥 Updated NDK version

    defaultConfig {
        applicationId = "com.example.student_nav_system"
        minSdk = 23  // Ensure this is set correctly
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11  // 🔥 Update from 8 to 11
        targetCompatibility = JavaVersion.VERSION_11  // 🔥 Update from 8 to 11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()  // 🔥 Update JVM target
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}


