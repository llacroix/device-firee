#!/bin/sh

# Copy files from a backup folder to the phone. Used to copy
# proprietary files that weren't built during the building process
# This script will get removed by an other script that will
# sync a working device and moved the files to a folder
# before building the image. This is used for development
# purpose only. 
#
# In the future, update to this file shouldn't be necessary

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

# etc/init.qcom.coex.sh
# vendor/lib/egl/eglsubAndroid.so
# vendor/lib/egl/libEGL_adreno.so
# vendor/lib/egl/libGLESv1_CM_adreno.so
# vendor/lib/egl/libGLESv2_adreno.so
# vendor/lib/egl/libq3dtools_adreno.so
# vendor/lib/libgsl.so
# vendor/lib/libadreno_utils.so
# bin/irsc_util

TEMP_BINS="
    bin/thermal-engine
    bin/qrngd
    bin/adsprpcd
    bin/cnd
    bin/ATFWD-daemon
    bin/mm-pp-daemon
    bin/ssr_diag
    bin/time_daemon
    bin/qseecomd
    bin/mm-qcamera-daemon
    bin/audiod
    bin/factory_test
    bin/trace_util
    bin/mverproxy
    bin/temp_monitor
    bin/nvdiag_daemon
    bin/qmuxd
    bin/rmt_storage
    bin/netmgrd
    bin/app_process
    etc/install-recovery.sh
    bin/ptt_socket_app
    bin/cnd
    bin/ATFWD-daemon
    bin/ssr_diag
    bin/qseecomd
    bin/audiod
    bin/factory_test
    bin/location-mq
    bin/xtwifi-inet-agent
    bin/xtwifi-client
    bin/lowi-server
    bin/charger_monitor
    bin/mpdecision
    bin/AcdApiDaemon
    bin/adsprpcd
    bin/alsaucm_test
    bin/amix
    bin/aplay
    bin/arec
    bin/backup.sh
    bin/bgservice
    bin/bluetoothd
    bin/brctl
    bin/bridgemgrd
    bin/btnvtool
    bin/bt_radio_run
    bin/bt_radio_stop
    bin/btTx_run
    bin/btTx_start
    bin/charger_monitor
    bin/crda
    bin/curl
    bin/diag_callback_client
    bin/diag_dci_sample
    bin/diag_klog
    bin/diag_mdlog
    bin/diag_socket_log
    bin/diag_uart_log
    bin/dsdnsutil
    bin/ds_fmc_appd
    bin/dun-server
    bin/ebtables
    bin/fmconfig
    bin/fmfactorytest
    bin/fmfactorytestserver
    bin/fm_qsoc_patches
    bin/fsck_msdos
    bin/ftmdaemon
    bin/garden_app
    bin/gpsone_daemon
    bin/gps_test
    bin/gsiff_daemon
    bin/hci_qcomm_init
    bin/install-recovery.sh
    bin/iperf
    bin/irsc_util
    bin/location-mq
    bin/lowi-server
    bin/mcDriverDaemon
    bin/mm-audio-ftm
    bin/mmitest
    bin/mm-jpeg-dec-test
    bin/mm-jpeg-enc-test
    bin/mm-jpeg-enc-test-client
    bin/mm-pp-daemon
    bin/mm-qcamera-app
    bin/mm-qcamera-daemon
    bin/mm-qjpeg-dec-test
    bin/mm-qjpeg-enc-test
    bin/mm-qomx-idec-test
    bin/mm-qomx-ienc-test
    bin/mpdecision
    bin/mtpd
    bin/mverproxy
    bin/netmgrd
    bin/nl_listener
    bin/n_smux
    bin/nvdiag_client
    bin/nvdiag_daemon
    bin/nvrw
    bin/pand
    bin/PktRspTest
    bin/port-bridge
    bin/pppd
    bin/ptt_socket_app
    bin/qcom-system-daemon
    bin/qmiproxy
    bin/qmuxd
    bin/qrngd
    bin/qrngp
    bin/qrngtest
    bin/quipc_igsn
    bin/quipc_main
    bin/radish
    bin/regdbdump
    bin/restore.sh
    bin/rfs_access
    bin/rmt_storage
    bin/sapd
    bin/sdptool
    bin/subsystem_ramdump
    bin/temp_monitor
    bin/test_diag
    bin/thermal-engine
    bin/time_daemon
    bin/trace_debug
    bin/trace_util
    bin/updater
    bin/usbhub
    bin/usbhub_init
    bin/wdsdaemon
    bin/wifitest
    bin/xtwifi-client
    bin/xtwifi-inet-agent
    "

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
    bin/mverproxy
    bin/trace_util
    bin/thermal-engine
    bin/time_daemon
    bin/temp_monitor
    bin/nvdiag_daemon
    bin/nvdiag_client
    "
# bin/rfs_access

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
    "
# vendor/lib/rfsa/adsp/libadsp_denoise_skel.so
# vendor/lib/rfsa/adsp/libadsp_jpege_skel.so

TEMP_LIBS="
    lib/bluez-plugin
    lib/crda
    lib/libacdapi_azi.so
    lib/liballjoyn.so
    lib/libalsa-intf.so
    lib/libandroid.so
    lib/libantradio.so
    lib/libaudioeffect_jni.so
    lib/libbcc.sha1.so
    lib/libbcc.so
    lib/libbcinfo.so
    lib/libbluedroid.so
    lib/libbluetoothd.so
    lib/libbluetooth.so
    lib/libbson.so
    lib/libbtio.so
    lib/libchromatix_imx135_liveshot.so
    lib/libclcore.bc
    lib/libclcore_debug.bc
    lib/libclcore_neon.bc
    lib/libcnefeatureconfig.so
    lib/libcompiler_rt.so
    lib/libcurl.so
    lib/libdrm1_jni.so
    lib/libebt_802_3.so
    lib/libebtable_broute.so
    lib/libebtable_filter.so
    lib/libebtable_nat.so
    lib/libebt_among.so
    lib/libebt_arpreply.so
    lib/libebt_arp.so
    lib/libebtc.so
    lib/libebt_ip6.so
    lib/libebt_ip.so
    lib/libebt_limit.so
    lib/libebt_log.so
    lib/libebt_mark_m.so
    lib/libebt_mark.so
    lib/libebt_nat.so
    lib/libebt_nflog.so
    lib/libebt_pkttype.so
    lib/libebt_redirect.so
    lib/libebt_standard.so
    lib/libebt_stp.so
    lib/libebt_ulog.so
    lib/libebt_vlan.so
    lib/libexif_jni.so
    lib/libexif.so
    lib/libFFTEm.so
    lib/libGLESv3.so
    lib/libglib.so
    lib/libgps.utils.so
    lib/libhwui.so
    lib/libjnigraphics.so
    lib/libLLVM.so
    lib/libloc_api_v02.so
    lib/libloc_core.so
    lib/libloc_ds_api.so
    lib/libloc_eng.so
    lib/libloc_xtra.so
    lib/libMcClient.so
    lib/libMcRegistry.so
    lib/libmmcamera_interface.so
    lib/libmmjpeg_interface.so
    lib/libmm-qcamera.so
    lib/libnvdiag_client.so
    lib/libnvrw.so
    lib/libOmxAacEnc.so
    lib/libOmxAmrEnc.so
    lib/libOmxEvrcEnc.so
    lib/libOmxQcelp13Enc.so
    lib/libOmxVdecHevc.so
    lib/libPaApi.so
    lib/libqomx_core.so
    lib/librecovery.so
    lib/libRScpp.so
    lib/libRSCpuRef.so
    lib/libRSDriver.so
    lib/libRS.so
    lib/libsoundpool.so
    lib/libSR_AudioIn.so
    lib/libstlport_shared.so
    lib/libstm-log.so
    lib/libsuapp_d_native.so
    lib/libsurfaceflinger_ddmconnection.so
    lib/libtinyxml.so
    lib/libtraceability.so
    lib/libxml2.so
    "


#copy_bins "$TEMP_BINS"
#copy_libs "$TEMP_LIBS"
copy_libs "$PUSH_LIBS"
copy_bins "$PUSH_BINS"

#adb shell "start b2g"

#adb reboot
