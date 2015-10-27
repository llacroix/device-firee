$(call inherit-product, device/qcom/msm8610/msm8610.mk)

PRODUCT_COPY_FILES := \
    device/qcom/msm8610/audio_policy.conf:system/etc/audio_policy.conf \
    device/qcom/msm8610/media/media_codecs_8610.xml:system/etc/media_codecs.xml \
    device/qcom/msm8610/media/media_profiles_8610.xml:system/etc/media_profiles.xml \
    device/qcom/msm8610/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    device/qcom/msm8610/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8610/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin \
    device/qcom/msm8610/snd_soc_msm/snd_soc_msm_8x10_wcd:system/etc/snd_soc_msm/snd_soc_msm_8x10_wcd \
    device/qcom/msm8610/snd_soc_msm/snd_soc_msm_8x10_wcd_skuaa:system/etc/snd_soc_msm/snd_soc_msm_8x10_wcd_skuaa \
    device/qcom/msm8610/snd_soc_msm/snd_soc_msm_8x10_wcd_skuab:system/etc/snd_soc_msm/snd_soc_msm_8x10_wcd_skuab \
	device/alcatel/firee/boot.ver:root/boot.ver \
	device/alcatel/firee/init.rc:root/init.rc \
	device/alcatel/firee/init.target.rc:root/init.target.rc \
	device/alcatel/firee/fstab.qcom:root/fstab.qcom \

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.moz.fm.noAnalog=true \
    ro.moz.nfc.enabled=false \
    ro.moz.devinputjack=1 \
    ro.moz.ril.0.network_types=gsm,wcdma \
    ro.moz.ril.emergency_by_default=true \
    ro.moz.ril.numclients=1 \
    ro.moz.ril.subscription_control=true \
    org.bluez.device.conn.type=array \

GAIA_DEV_PIXELS_PER_PX := 2

PRODUCT_NAME := firee
PRODUCT_DEVICE := firee
PRODUCT_BRAND := qcom
PRODUCT_MANUFACTURER := alcatel
PRODUCT_MODEL := firee
