plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.rightads.right_ads"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    buildFeatures {
        resValues = true
    }

    defaultConfig {
        applicationId = "com.rightads.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "default"
    productFlavors {
        create("dev") {
            dimension = "default"
            resValue("string", "app_name", "Right Ads (Dev)")
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "Right Ads (Staging)")
        }
        create("prod") {
            dimension = "default"
            resValue("string", "app_name", "Right Ads")
        }
    }

    buildTypes {
        release {
            // Signing with the debug keys for local release verification when no keystore is supplied.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}

if (file("google-services.json").exists()) {
    apply(plugin = "com.google.gms.google-services")
}

// Support plain `flutter run` without --flavor by linking the dev APK output to app-debug.apk
afterEvaluate {
    tasks.findByName("assembleDebug")?.doLast {
        val devApk = layout.buildDirectory.file("outputs/apk/dev/debug/app-dev-debug.apk").get().asFile
        val targetApk = layout.buildDirectory.file("outputs/flutter-apk/app-debug.apk").get().asFile
        if (devApk.exists()) {
            targetApk.parentFile.mkdirs()
            devApk.copyTo(targetApk, overwrite = true)
        }
    }
}
