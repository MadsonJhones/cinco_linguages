plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.cinco_linguagens"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.cinco_linguagens"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = "flutter" // Escreva aqui o alias da sua chave
            keyPassword = "Xux@fever2019" // Escreva aqui a senha da chave
            storeFile = file("F:/Programacao/Flutter/cinco_linguagens/android/app/flutter_release.keystore") // Caminho para o arquivo keystore
            storePassword = "Xux@fever2019" // Escreva aqui a senha do keystore
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release") // Atribuindo a configuração de assinatura para o release

            // As propriedades do ProGuard podem ser configuradas aqui
            isMinifyEnabled = true // Habilita o ProGuard para otimizar o código
            isShrinkResources = true // Reduz o tamanho dos recursos
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro") // Configuração do ProGuard
        }
    }
}

flutter {
    source = "../.."
}
