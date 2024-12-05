# Mantener las clases relacionadas con Stripe PushProvisioning
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

# Mantener las clases de Stripe en general
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**
