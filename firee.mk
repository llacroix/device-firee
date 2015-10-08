$(call inherit-product, device/qcom/msm8610/msm8610.mk)

PRODUCT_COPY_FILES := \
	device/alcatel/firee/boot.ver:root/boot.ver \
	device/alcatel/firee/init.rc:root/init.rc \
	device/alcatel/firee/init.target.rc:root/init.target.rc \
	device/alcatel/firee/fstab.qcom:root/fstab.qcom \

GAIA_DEV_PIXELS_PER_PX := 1.5

PRODUCT_NAME := firee
PRODUCT_DEVICE := firee
PRODUCT_BRAND := qcom
PRODUCT_MANUFACTURER := alcatel
PRODUCT_MODEL := firee
