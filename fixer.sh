#!/bin/sh

BASE_DIR="backup"
TARGET="/system"

function copy_bins() {
    for FILE in $1
    do
        adb shell "ls ${TARGET}/${FILE}" | grep "No such"

        if [ $? -eq 0 ]
        then
            echo "Copying from ${BASE_DIR}/${FILE} to ${TARGET}/${FILE}"
            adb push "${BASE_DIR}/${FILE}" "${TARGET}/${FILE}"
            adb shell "chmod 755 ${TARGET}/${FILE}"
        fi
    done
}

function copy_libs_forced() {
    for FILE in $1
    do
        adb push "${BASE_DIR}/${FILE}" "${TARGET}/${FILE}"
        adb shell "chmod 644 ${TARGET}/${FILE}"
    done
}

function copy_libs() {
    for FILE in $1
    do
        adb shell "ls ${TARGET}/${FILE}" | grep "No such"

        if [ $? -eq 0 ]
        then
            echo "Copying from ${BASE_DIR}/${FILE} to ${TARGET}/${FILE}"
            adb push "${BASE_DIR}/${FILE}" "${TARGET}/${FILE}"
            adb shell "chmod 644 ${TARGET}/${FILE}"
        fi
    done
}

adb wait-for-device
adb remount

adb shell "mkdir /system/media"
adb shell "mkdir -p /data/misc/wifi"
adb shell "mkdir -p /system/vendor/lib/rfsa/adsp"
# adb shell "mkdir /system/vendor/lib/egl"

#adb shell "stop b2g"

PUSH_BINS="
    bin/irsc_util
    bin/netmgrd
    bin/rmt_storage
    bin/fakeperm
    bin/qmuxd
    bin/qcom-system-daemon
    bin/AcdApiDaemon
    bin/adsprpcd
    bin/ptt_socket_app
    bin/mm-pp-daemon
    bin/rfs_access
    bin/aplay
    bin/qrngp
    bin/qrngd
    bin/mpdecision
    bin/mm-qcamera-daemon
    bin/fsck_msdos
    bin/newfs_msdos
    bin/mverproxy
    bin/trace_util
    bin/thermal-engine
    bin/time_daemon
    bin/temp_monitor
    bin/nvdiag_daemon
    bin/nvdiag_client
    bin/hci_qcomm_init
    bin/btnvtool
    "
#Not sure what it does
#    bin/location-mq
# Probably not necessary
# bin/bluetoothd

PUSH_LIBS="
    vendor/lib/libqc-opt.so
    media/bootanimation.zip
    usr/idc/Atmel_maXTouch_Touchscreen_controller.idc
    usr/idc/atmel_mxt_ts.idc
    usr/idc/atmel-touchscreen.idc
    usr/idc/ft5x06_ts.idc
    usr/idc/ft5x0x_ts.idc
    usr/idc/msg2133.idc
    usr/idc/sensor00fn11.idc
    etc/firmware/a225p5_pm4.fw
    etc/firmware/a225_pfp.fw
    etc/firmware/a225_pm4.fw
    etc/firmware/a300_pfp.fw
    etc/firmware/a300_pm4.fw
    etc/firmware/a330_pfp.fw
    etc/firmware/a330_pm4.fw
    etc/firmware/cpp_firmware_v1_1_1.fw
    etc/firmware/cpp_firmware_v1_1_6.fw
    etc/firmware/cpp_firmware_v1_2_0.fw
    etc/firmware/leia_pfp_470.fw
    etc/firmware/leia_pm4_470.fw
    etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin
    etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini
    etc/wifi/wpa_supplicant.conf
    etc/wifi/wpa_supplicant_ath6kl.conf
    etc/wifi/wpa_supplicant_wcn.conf
    etc/wifi/WCNSS_qcom_cfg.ini
    vendor/lib/libgsl.so
    vendor/lib/egl/eglsubAndroid.so
    vendor/lib/egl/libEGL_adreno.so
    vendor/lib/egl/libGLESv1_CM_adreno.so
    vendor/lib/egl/libGLESv2_adreno.so
    vendor/lib/egl/libq3dtools_adreno.so
    vendor/lib/libadreno_utils.so
    vendor/lib/libsc-a3xx.so
    vendor/lib/libril-qc-qmi-1.so
    vendor/lib/libril-qcril-hook-oem.so
    etc/sec_config
    vendor/lib/libdiag.so
    vendor/lib/libdsutils.so
    vendor/lib/libqmi_cci.so
    vendor/lib/libqmi_common_so.so
    vendor/lib/libqmi_csvt_srvc.so
    vendor/lib/libqmiservices.so
    vendor/lib/libqmi_client_qmux.so
    vendor/lib/libqmi_csi.so
    vendor/lib/libqmi_encdec.so
    vendor/lib/libqmi.so
    vendor/lib/libidl.so
    vendor/lib/libnetmgr.so
    vendor/lib/libsubsystem_control.so
    lib/libacdapi_azi.so
    vendor/lib/libadsprpc.so
    vendor/lib/libdisp-aba.so
    vendor/lib/libmm-abl.so
    vendor/lib/libmm-abl-oem.so
    vendor/lib/soundfx/libqcbassboost.so
    vendor/lib/soundfx/libqcvirt.so
    vendor/lib/rfsa/adsp/libadsp_denoise_skel.so
    vendor/lib/rfsa/adsp/libadsp_jpege_skel.so
    lib/libalsa-intf.so
    vendor/lib/libacdbloader.so
    vendor/lib/libaudcal.so
    vendor/lib/libacdbrtac.so
    vendor/lib/libadiertac.so
    vendor/lib/liboemcamera.so
    vendor/lib/libmmcamera2_c2d_module.so           
    vendor/lib/libmmcamera2_cpp_module.so           
    vendor/lib/libmmcamera2_iface_modules.so        
    vendor/lib/libmmcamera2_imglib_modules.so       
    vendor/lib/libmmcamera2_isp_modules.so          
    vendor/lib/libmmcamera2_pproc_modules.so        
    vendor/lib/libmmcamera2_sensor_modules.so       
    vendor/lib/libmmcamera2_stats_algorithm.so      
    vendor/lib/libmmcamera2_stats_modules.so        
    vendor/lib/libmmcamera2_vpe_module.so           
    vendor/lib/libmmcamera2_wnr_module.so           
    vendor/lib/libmmcamera_faceproc.so              
    vendor/lib/libmmcamera_gc2035.so                
    vendor/lib/libmmcamera_hdr_gb_lib.so            
    vendor/lib/libmmcamera_hdr_lib.so               
    vendor/lib/libmmcamera_hi256.so                 
    vendor/lib/libmmcamera_hi258.so                 
    vendor/lib/libmmcamera_imglib.so                
    vendor/lib/libmmcamera_imx134.so                
    vendor/lib/libmmcamera_imx135.so                
    vendor/lib/libmmcamera_mt9m114.so                      
    vendor/lib/libmmcamera_ofilm_oty5f03_eeprom.so
    vendor/lib/libmmcamera_ov2720.so
    vendor/lib/libmmcamera_ov5648_oty5f03.so
    vendor/lib/libmmcamera_ov8825.so
    vendor/lib/libmmcamera_ov8865_q8v18a.so
    vendor/lib/libmmcamera_ov9724.so
    vendor/lib/libmmcamera_s5k3l1yx.so
    vendor/lib/libmmcamera_SKUAA_ewelly_gc0339.so
    vendor/lib/libmmcamera_SKUAA_ST_gc0339.so
    vendor/lib/libmmcamera_skuab_shinetech_gc0339.so
    vendor/lib/libmmcamera_SKUAB_ST_s5k4e1.so
    vendor/lib/libmmcamera_skuf_ov12830_p12v01c.so
    vendor/lib/libmmcamera_skuf_ov5648_p5v23c.so
    vendor/lib/libmmcamera_sp1628.so
    vendor/lib/libmmcamera_sunny_p12v01m_eeprom.so
    vendor/lib/libmmcamera_sunny_p5v23c_eeprom.so
    vendor/lib/libmmcamera_sunny_q8v18a_eeprom.so
    vendor/lib/libmmcamera_tintless_algo.so
    vendor/lib/libmmcamera_tintless_bg_pca_algo.so
    vendor/lib/libmmcamera_truly_cm7700_eeprom.so
    vendor/lib/libmmcamera_tuning.so
    vendor/lib/libmmcamera_wavelet_lib.so           
    etc/Bluetooth_cal.acdb
    etc/Global_cal.acdb
    etc/Hdmi_cal.acdb
    etc/Speaker_cal.acdb
    etc/General_cal.acdb
    etc/Handset_cal.acdb
    etc/Headset_cal.acdb
    etc/acdapi/calib.dat
    etc/acdapi/param.dat
    etc/acdapi/sensors.dat
    vendor/lib/libthermalioctl.so
    etc/izat.conf
    etc/bluetooth/audio.conf
    etc/bluetooth/main.conf
    etc/bluetooth/stack.conf
    lib/hw/camera.msm8610.so
    lib/hw/audio_policy.default.so
    lib/hw/audio.primary.msm8610.so
    lib/hw/sensors.msm8610.so
    lib/hw/gps.default.so
    lib/libmmcamera_interface.so
    vendor/lib/libsurround_proc.so
    etc/thermal-engine-8610.conf
    lib/libmmjpeg_interface.so
    lib/libqomx_core.so
    lib/bluez-plugin/audio.so
    lib/bluez-plugin/bluetooth-health.so
    lib/bluez-plugin/input.so
    lib/bluez-plugin/network.so
    vendor/lib/libgeofence.so
    vendor/lib/libqcci_legacy.so
    vendor/lib/libtime_genoff.so
    vendor/lib/libdsi_netctrl.so
    vendor/lib/libqdi.so
    vendor/lib/libqdp.so
    vendor/lib/libdsnetutils.so
    lib/libloc_eng.so
    lib/libloc_core.so
    lib/libgps.utils.so
    etc/sap.conf
    lib/libloc_api_v02.so
    lib/libloc_ds_api.so
    lib/libloc_xtra.so
    vendor/lib/liblocationservice.so
    vendor/lib/libloc_ext.so
    etc/xtwifi.conf
    lib/libbluetoothd.so
    lib/libbluetooth.so
    lib/libbtio.so
    lib/libglib.so
    lib/librecovery.so
    vendor/lib/libC2D2.so
    vendor/lib/libc2d2_z180.so
    vendor/lib/libc2d30-a3xx.so
    vendor/lib/libc2d30-a4xx.so
    vendor/lib/libc2d30.so     
    vendor/lib/libfastcvopt.so
    vendor/lib/libchromatix_imx134_common.so
    vendor/lib/libchromatix_imx134_default_video.so
    vendor/lib/libchromatix_imx134_hfr_120.so
    vendor/lib/libchromatix_imx134_hfr_60.so
    vendor/lib/libchromatix_imx134_preview.so
    vendor/lib/libchromatix_imx134_snapshot.so
    vendor/lib/libchromatix_imx135_common.so
    vendor/lib/libchromatix_imx135_default_video.so
    vendor/lib/libchromatix_imx135_hfr_120.so
    vendor/lib/libchromatix_imx135_preview.so
    vendor/lib/libchromatix_imx135_snapshot.so
    vendor/lib/libchromatix_imx135_video_hd.so
    vendor/lib/libchromatix_ov2720_common.so
    vendor/lib/libchromatix_ov2720_default_video.so
    vendor/lib/libchromatix_ov2720_hfr.so
    vendor/lib/libchromatix_ov2720_liveshot.so
    vendor/lib/libchromatix_ov2720_preview.so
    vendor/lib/libchromatix_ov2720_zsl.so
    vendor/lib/libchromatix_ov5648_oty5f03_common.so
    vendor/lib/libchromatix_ov5648_oty5f03_default_video.so
    vendor/lib/libchromatix_ov5648_oty5f03_preview.so
    vendor/lib/libchromatix_ov5648_oty5f03_snapshot.so
    vendor/lib/libchromatix_ov5648_oty5f03_zsl.so
    vendor/lib/libchromatix_ov8825_7853f_common.so
    vendor/lib/libchromatix_ov8825_7853f_default_video.so
    vendor/lib/libchromatix_ov8825_7853f_hfr_120fps.so
    vendor/lib/libchromatix_ov8825_7853f_hfr_60fps.so
    vendor/lib/libchromatix_ov8825_7853f_hfr_90fps.so
    vendor/lib/libchromatix_ov8825_7853f_liveshot.so
    vendor/lib/libchromatix_ov8825_7853f_preview.so
    vendor/lib/libchromatix_ov8825_7853f_snapshot.so
    vendor/lib/libchromatix_ov8825_7853f_zsl.so
    vendor/lib/libchromatix_ov8825_liveshot_hd.so
    vendor/lib/libchromatix_ov8825_preview_hd.so
    vendor/lib/libchromatix_ov8825_snapshot_hd.so
    vendor/lib/libchromatix_ov8825_video_hd.so
    vendor/lib/libchromatix_ov8865_q8v18a_common.so
    vendor/lib/libchromatix_ov8865_q8v18a_default_video.so
    vendor/lib/libchromatix_ov8865_q8v18a_hfr_120fps.so
    vendor/lib/libchromatix_ov8865_q8v18a_hfr_60fps.so
    vendor/lib/libchromatix_ov8865_q8v18a_hfr_90fps.so
    vendor/lib/libchromatix_ov8865_q8v18a_liveshot.so
    vendor/lib/libchromatix_ov8865_q8v18a_preview.so
    vendor/lib/libchromatix_ov8865_q8v18a_snapshot.so
    vendor/lib/libchromatix_ov8865_q8v18a_video_hd.so
    vendor/lib/libchromatix_ov8865_q8v18a_zsl.so
    vendor/lib/libchromatix_ov9724_common.so
    vendor/lib/libchromatix_ov9724_default_video.so
    vendor/lib/libchromatix_ov9724_liveshot.so
    vendor/lib/libchromatix_ov9724_preview.so
    vendor/lib/libchromatix_s5k3l1yx_common.so
    vendor/lib/libchromatix_s5k3l1yx_default_video.so
    vendor/lib/libchromatix_s5k3l1yx_hfr_120fps.so
    vendor/lib/libchromatix_s5k3l1yx_hfr_60fps.so
    vendor/lib/libchromatix_s5k3l1yx_hfr_90fps.so
    vendor/lib/libchromatix_s5k3l1yx_liveshot.so
    vendor/lib/libchromatix_s5k3l1yx_preview.so
    vendor/lib/libchromatix_s5k3l1yx_snapshot.so
    vendor/lib/libchromatix_s5k3l1yx_video_hd.so
    vendor/lib/libchromatix_s5k3l1yx_zsl.so
    vendor/lib/libchromatix_SKUAA_ewelly_gc0339_common.so
    vendor/lib/libchromatix_SKUAA_ewelly_gc0339_default_video.so
    vendor/lib/libchromatix_SKUAA_ewelly_gc0339_preview.so
    vendor/lib/libchromatix_SKUAA_ST_gc0339_common.so
    vendor/lib/libchromatix_SKUAA_ST_gc0339_default_video.so
    vendor/lib/libchromatix_SKUAA_ST_gc0339_preview.so
    vendor/lib/libchromatix_skuab_shinetech_gc0339_common.so
    vendor/lib/libchromatix_skuab_shinetech_gc0339_default_video.so
    vendor/lib/libchromatix_skuab_shinetech_gc0339_liveshot.so
    vendor/lib/libchromatix_skuab_shinetech_gc0339_preview.so
    vendor/lib/libchromatix_skuab_shinetech_gc0339_snapshot.so
    vendor/lib/libchromatix_skuab_shinetech_gc0339_zsl.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_common.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_default_video.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_hfr_120fps.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_hfr_60fps.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_hfr_90fps.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_liveshot.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_preview.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_snapshot.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_video_hd.so
    vendor/lib/libchromatix_SKUAB_ST_s5k4e1_zsl.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_common.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_default_video.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_hfr_120fps.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_hfr_60fps.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_hfr_90fps.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_preview.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_snapshot.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_video_hd.so
    vendor/lib/libchromatix_skuf_ov12830_p12v01c_zsl.so
    vendor/lib/libchromatix_skuf_ov5648_p5v23c_common.so
    vendor/lib/libchromatix_skuf_ov5648_p5v23c_default_video.so
    vendor/lib/libchromatix_skuf_ov5648_p5v23c_preview.so
    vendor/lib/libchromatix_skuf_ov5648_p5v23c_snapshot.so
    "
#   b2g/distribution/bundles/libqc_b2g_ril/SmsHelper.js
#   b2g/distribution/bundles/libqc_b2g_ril/chrome.manifest
#   b2g/distribution/bundles/libqc_b2g_ril/libqc_b2g_ril.so
#   b2g/distribution/bundles/libqc_b2g_ril/content_helper
#   b2g/distribution/bundles/libqc_b2g_ril/content_helper/QCMessageManager.js
#   b2g/distribution/bundles/libqc_b2g_ril/content_helper/QCTimeService.js
#   b2g/distribution/bundles/libqc_b2g_ril/content_helper/QCContentHelper.js
#   b2g/distribution/bundles/libqc_b2g_ril/libqc_b2g_ril.xpt
#   b2g/distribution/bundles/libqc_b2g_ril/interfaces.manifest

FORCED_LIBS="
    etc/snd_soc_msm/snd_soc_msm_8x10_wcd_skuaa
    "

copy_libs "$PUSH_LIBS"
copy_libs_forced "$FORCED_LIBS"
copy_bins "$PUSH_BINS"

#adb shell "start b2g"

#adb reboot
