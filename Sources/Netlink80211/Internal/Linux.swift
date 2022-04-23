//
//  Linux.swift
//  
//
//  Created by Alsey Coleman Miller on 4/22/22.
//

#if !os(Linux)

public var NL80211_GENL_NAME: String { "nl80211" }

public var NL80211_MULTICAST_GROUP_CONFIG: String { "config" }
public var NL80211_MULTICAST_GROUP_SCAN: String { "scan" }
public var NL80211_MULTICAST_GROUP_REG: String { "regulatory" }
public var NL80211_MULTICAST_GROUP_MLME: String { "mlme" }
public var NL80211_MULTICAST_GROUP_VENDOR: String { "vendor" }
public var NL80211_MULTICAST_GROUP_TESTMODE: String { "testmode" }

public struct nl80211_commands: RawRepresentable, Equatable, Hashable {
    
    public var rawValue: CInt {
        value.rawValue
    }
    public init?(rawValue: CInt) {
        guard let value = _nl80211_commands(rawValue: rawValue) else {
            return nil
        }
        self.init(value)
    }
    
    let value: _nl80211_commands
    init(_ value: _nl80211_commands) {
        self.value = value
    }
}

public var NL80211_CMD_TRIGGER_SCAN: nl80211_commands { .init(.NL80211_CMD_TRIGGER_SCAN) }
public var NL80211_CMD_GET_SCAN: nl80211_commands { .init(.NL80211_CMD_GET_SCAN) }
public var NL80211_CMD_NEW_SCAN_RESULTS: nl80211_commands { .init(.NL80211_CMD_NEW_SCAN_RESULTS) }
public var NL80211_CMD_GET_INTERFACE: nl80211_commands { .init(.NL80211_CMD_GET_INTERFACE) }

enum _nl80211_commands: CInt {
    /* don't change the order or add anything between this is ABI! */
    case NL80211_CMD_UNSPEC

    case NL80211_CMD_GET_WIPHY        /* can dump */
    case NL80211_CMD_SET_WIPHY
    case NL80211_CMD_NEW_WIPHY
    case NL80211_CMD_DEL_WIPHY

    case NL80211_CMD_GET_INTERFACE    /* can dump */
    case NL80211_CMD_SET_INTERFACE
    case NL80211_CMD_NEW_INTERFACE
    case NL80211_CMD_DEL_INTERFACE

    case NL80211_CMD_GET_KEY
    case NL80211_CMD_SET_KEY
    case NL80211_CMD_NEW_KEY
    case NL80211_CMD_DEL_KEY

    case NL80211_CMD_GET_BEACON
    case NL80211_CMD_SET_BEACON
    case NL80211_CMD_START_AP
    static var NL80211_CMD_NEW_BEACON: _nl80211_commands { .NL80211_CMD_START_AP }
    case NL80211_CMD_STOP_AP
    static var NL80211_CMD_DEL_BEACON: _nl80211_commands { .NL80211_CMD_STOP_AP }

    case NL80211_CMD_GET_STATION
    case NL80211_CMD_SET_STATION
    case NL80211_CMD_NEW_STATION
    case NL80211_CMD_DEL_STATION

    case NL80211_CMD_GET_MPATH
    case NL80211_CMD_SET_MPATH
    case NL80211_CMD_NEW_MPATH
    case NL80211_CMD_DEL_MPATH

    case NL80211_CMD_SET_BSS

    case NL80211_CMD_SET_REG
    case NL80211_CMD_REQ_SET_REG

    case NL80211_CMD_GET_MESH_CONFIG
    case NL80211_CMD_SET_MESH_CONFIG

    case NL80211_CMD_SET_MGMT_EXTRA_IE /* reserved; not used */

    case NL80211_CMD_GET_REG

    case NL80211_CMD_GET_SCAN
    case NL80211_CMD_TRIGGER_SCAN
    case NL80211_CMD_NEW_SCAN_RESULTS
    case NL80211_CMD_SCAN_ABORTED

    case NL80211_CMD_REG_CHANGE

    case NL80211_CMD_AUTHENTICATE
    case NL80211_CMD_ASSOCIATE
    case NL80211_CMD_DEAUTHENTICATE
    case NL80211_CMD_DISASSOCIATE

    case NL80211_CMD_MICHAEL_MIC_FAILURE

    case NL80211_CMD_REG_BEACON_HINT

    case NL80211_CMD_JOIN_IBSS
    case NL80211_CMD_LEAVE_IBSS

    case NL80211_CMD_TESTMODE

    case NL80211_CMD_CONNECT
    case NL80211_CMD_ROAM
    case NL80211_CMD_DISCONNECT

    case NL80211_CMD_SET_WIPHY_NETNS

    case NL80211_CMD_GET_SURVEY
    case NL80211_CMD_NEW_SURVEY_RESULTS

    case NL80211_CMD_SET_PMKSA
    case NL80211_CMD_DEL_PMKSA
    case NL80211_CMD_FLUSH_PMKSA

    case NL80211_CMD_REMAIN_ON_CHANNEL
    case NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL

    case NL80211_CMD_SET_TX_BITRATE_MASK

    case NL80211_CMD_REGISTER_FRAME
    static var NL80211_CMD_REGISTER_ACTION: _nl80211_commands { .NL80211_CMD_REGISTER_FRAME }
    case NL80211_CMD_FRAME
    static var NL80211_CMD_ACTION: _nl80211_commands { .NL80211_CMD_FRAME }
    case NL80211_CMD_FRAME_TX_STATUS
    static var NL80211_CMD_ACTION_TX_STATUS: _nl80211_commands { .NL80211_CMD_FRAME_TX_STATUS }

    case NL80211_CMD_SET_POWER_SAVE
    case NL80211_CMD_GET_POWER_SAVE

    case NL80211_CMD_SET_CQM
    case NL80211_CMD_NOTIFY_CQM

    case NL80211_CMD_SET_CHANNEL
    case NL80211_CMD_SET_WDS_PEER

    case NL80211_CMD_FRAME_WAIT_CANCEL

    case NL80211_CMD_JOIN_MESH
    case NL80211_CMD_LEAVE_MESH

    case NL80211_CMD_UNPROT_DEAUTHENTICATE
    case NL80211_CMD_UNPROT_DISASSOCIATE

    case NL80211_CMD_NEW_PEER_CANDIDATE

    case NL80211_CMD_GET_WOWLAN
    case NL80211_CMD_SET_WOWLAN

    case NL80211_CMD_START_SCHED_SCAN
    case NL80211_CMD_STOP_SCHED_SCAN
    case NL80211_CMD_SCHED_SCAN_RESULTS
    case NL80211_CMD_SCHED_SCAN_STOPPED

    case NL80211_CMD_SET_REKEY_OFFLOAD

    case NL80211_CMD_PMKSA_CANDIDATE

    case NL80211_CMD_TDLS_OPER
    case NL80211_CMD_TDLS_MGMT

    case NL80211_CMD_UNEXPECTED_FRAME

    case NL80211_CMD_PROBE_CLIENT

    case NL80211_CMD_REGISTER_BEACONS

    case NL80211_CMD_UNEXPECTED_4ADDR_FRAME

    case NL80211_CMD_SET_NOACK_MAP

    case NL80211_CMD_CH_SWITCH_NOTIFY

    case NL80211_CMD_START_P2P_DEVICE
    case NL80211_CMD_STOP_P2P_DEVICE

    case NL80211_CMD_CONN_FAILED

    case NL80211_CMD_SET_MCAST_RATE

    case NL80211_CMD_SET_MAC_ACL

    case NL80211_CMD_RADAR_DETECT

    case NL80211_CMD_GET_PROTOCOL_FEATURES

    case NL80211_CMD_UPDATE_FT_IES
    case NL80211_CMD_FT_EVENT

    case NL80211_CMD_CRIT_PROTOCOL_START
    case NL80211_CMD_CRIT_PROTOCOL_STOP

    case NL80211_CMD_GET_COALESCE
    case NL80211_CMD_SET_COALESCE

    case NL80211_CMD_CHANNEL_SWITCH

    case NL80211_CMD_VENDOR

    case NL80211_CMD_SET_QOS_MAP

    case NL80211_CMD_ADD_TX_TS
    case NL80211_CMD_DEL_TX_TS

    case NL80211_CMD_GET_MPP

    case NL80211_CMD_JOIN_OCB
    case NL80211_CMD_LEAVE_OCB

    case NL80211_CMD_CH_SWITCH_STARTED_NOTIFY

    case NL80211_CMD_TDLS_CHANNEL_SWITCH
    case NL80211_CMD_TDLS_CANCEL_CHANNEL_SWITCH

    case NL80211_CMD_WIPHY_REG_CHANGE

    case NL80211_CMD_ABORT_SCAN
}

public struct nl80211_attrs: RawRepresentable, Equatable, Hashable {
    
    public var rawValue: CInt {
        value.rawValue
    }
    public init?(rawValue: CInt) {
        guard let value = _nl80211_attrs(rawValue: rawValue) else {
            return nil
        }
        self.init(value)
    }
    
    let value: _nl80211_attrs
    init(_ value: _nl80211_attrs) {
        self.value = value
    }
}

public var NL80211_ATTR_WIPHY: nl80211_attrs { .init(.NL80211_ATTR_WIPHY) }

public var NL80211_ATTR_WIPHY_NAME: nl80211_attrs { .init(.NL80211_ATTR_WIPHY_NAME) }

public var NL80211_ATTR_WIPHY_FREQ: nl80211_attrs { .init(.NL80211_ATTR_WIPHY_FREQ) }

public var NL80211_ATTR_IFINDEX: nl80211_attrs { .init(.NL80211_ATTR_IFINDEX) }

public var NL80211_ATTR_IFNAME: nl80211_attrs { .init(.NL80211_ATTR_IFNAME) }

public var NL80211_ATTR_IFTYPE: nl80211_attrs { .init(.NL80211_ATTR_IFTYPE) }

public var NL80211_ATTR_MAC: nl80211_attrs { .init(.NL80211_ATTR_MAC) }

public var NL80211_ATTR_BSS: nl80211_attrs { .init(.NL80211_ATTR_BSS) }

public var NL80211_ATTR_SCAN_FREQUENCIES: nl80211_attrs { .init(.NL80211_ATTR_SCAN_FREQUENCIES) }

public var NL80211_ATTR_SCAN_SSIDS: nl80211_attrs { .init(.NL80211_ATTR_SCAN_SSIDS) }

public var NL80211_ATTR_GENERATION: nl80211_attrs { .init(.NL80211_ATTR_GENERATION) }

public var NL80211_ATTR_WDEV: nl80211_attrs { .init(.NL80211_ATTR_WDEV) }

enum _nl80211_attrs: CInt {
/* don't change the order or add anything between this is ABI! */
    case NL80211_ATTR_UNSPEC

    case NL80211_ATTR_WIPHY
    case NL80211_ATTR_WIPHY_NAME

    case NL80211_ATTR_IFINDEX
    case NL80211_ATTR_IFNAME
    case NL80211_ATTR_IFTYPE

    case NL80211_ATTR_MAC

    case NL80211_ATTR_KEY_DATA
    case NL80211_ATTR_KEY_IDX
    case NL80211_ATTR_KEY_CIPHER
    case NL80211_ATTR_KEY_SEQ
    case NL80211_ATTR_KEY_DEFAULT

    case NL80211_ATTR_BEACON_INTERVAL
    case NL80211_ATTR_DTIM_PERIOD
    case NL80211_ATTR_BEACON_HEAD
    case NL80211_ATTR_BEACON_TAIL

    case NL80211_ATTR_STA_AID
    case NL80211_ATTR_STA_FLAGS
    case NL80211_ATTR_STA_LISTEN_INTERVAL
    case NL80211_ATTR_STA_SUPPORTED_RATES
    case NL80211_ATTR_STA_VLAN
    case NL80211_ATTR_STA_INFO

    case NL80211_ATTR_WIPHY_BANDS

    case NL80211_ATTR_MNTR_FLAGS

    case NL80211_ATTR_MESH_ID
    case NL80211_ATTR_STA_PLINK_ACTION
    case NL80211_ATTR_MPATH_NEXT_HOP
    case NL80211_ATTR_MPATH_INFO

    case NL80211_ATTR_BSS_CTS_PROT
    case NL80211_ATTR_BSS_SHORT_PREAMBLE
    case NL80211_ATTR_BSS_SHORT_SLOT_TIME

    case NL80211_ATTR_HT_CAPABILITY

    case NL80211_ATTR_SUPPORTED_IFTYPES

    case NL80211_ATTR_REG_ALPHA2
    case NL80211_ATTR_REG_RULES

    case NL80211_ATTR_MESH_CONFIG

    case NL80211_ATTR_BSS_BASIC_RATES

    case NL80211_ATTR_WIPHY_TXQ_PARAMS
    case NL80211_ATTR_WIPHY_FREQ
    case NL80211_ATTR_WIPHY_CHANNEL_TYPE

    case NL80211_ATTR_KEY_DEFAULT_MGMT

    case NL80211_ATTR_MGMT_SUBTYPE
    case NL80211_ATTR_IE

    case NL80211_ATTR_MAX_NUM_SCAN_SSIDS

    case NL80211_ATTR_SCAN_FREQUENCIES
    case NL80211_ATTR_SCAN_SSIDS
    case NL80211_ATTR_GENERATION /* replaces old SCAN_GENERATION */
    case NL80211_ATTR_BSS

    case NL80211_ATTR_REG_INITIATOR
    case NL80211_ATTR_REG_TYPE

    case NL80211_ATTR_SUPPORTED_COMMANDS

    case NL80211_ATTR_FRAME
    case NL80211_ATTR_SSID
    case NL80211_ATTR_AUTH_TYPE
    case NL80211_ATTR_REASON_CODE

    case NL80211_ATTR_KEY_TYPE

    case NL80211_ATTR_MAX_SCAN_IE_LEN
    case NL80211_ATTR_CIPHER_SUITES

    case NL80211_ATTR_FREQ_BEFORE
    case NL80211_ATTR_FREQ_AFTER

    case NL80211_ATTR_FREQ_FIXED


    case NL80211_ATTR_WIPHY_RETRY_SHORT
    case NL80211_ATTR_WIPHY_RETRY_LONG
    case NL80211_ATTR_WIPHY_FRAG_THRESHOLD
    case NL80211_ATTR_WIPHY_RTS_THRESHOLD

    case NL80211_ATTR_TIMED_OUT

    case NL80211_ATTR_USE_MFP

    case NL80211_ATTR_STA_FLAGS2

    case NL80211_ATTR_CONTROL_PORT

    case NL80211_ATTR_TESTDATA

    case NL80211_ATTR_PRIVACY

    case NL80211_ATTR_DISCONNECTED_BY_AP
    case NL80211_ATTR_STATUS_CODE

    case NL80211_ATTR_CIPHER_SUITES_PAIRWISE
    case NL80211_ATTR_CIPHER_SUITE_GROUP
    case NL80211_ATTR_WPA_VERSIONS
    case NL80211_ATTR_AKM_SUITES

    case NL80211_ATTR_REQ_IE
    case NL80211_ATTR_RESP_IE

    case NL80211_ATTR_PREV_BSSID

    case NL80211_ATTR_KEY
    case NL80211_ATTR_KEYS

    case NL80211_ATTR_PID

    case NL80211_ATTR_4ADDR

    case NL80211_ATTR_SURVEY_INFO

    case NL80211_ATTR_PMKID
    case NL80211_ATTR_MAX_NUM_PMKIDS

    case NL80211_ATTR_DURATION

    case NL80211_ATTR_COOKIE

    case NL80211_ATTR_WIPHY_COVERAGE_CLASS

    case NL80211_ATTR_TX_RATES

    case NL80211_ATTR_FRAME_MATCH

    case NL80211_ATTR_ACK

    case NL80211_ATTR_PS_STATE

    case NL80211_ATTR_CQM

    case NL80211_ATTR_LOCAL_STATE_CHANGE

    case NL80211_ATTR_AP_ISOLATE

    case NL80211_ATTR_WIPHY_TX_POWER_SETTING
    case NL80211_ATTR_WIPHY_TX_POWER_LEVEL

    case NL80211_ATTR_TX_FRAME_TYPES
    case NL80211_ATTR_RX_FRAME_TYPES
    case NL80211_ATTR_FRAME_TYPE

    case NL80211_ATTR_CONTROL_PORT_ETHERTYPE
    case NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT

    case NL80211_ATTR_SUPPORT_IBSS_RSN

    case NL80211_ATTR_WIPHY_ANTENNA_TX
    case NL80211_ATTR_WIPHY_ANTENNA_RX

    case NL80211_ATTR_MCAST_RATE

    case NL80211_ATTR_OFFCHANNEL_TX_OK

    case NL80211_ATTR_BSS_HT_OPMODE

    case NL80211_ATTR_KEY_DEFAULT_TYPES

    case NL80211_ATTR_MAX_REMAIN_ON_CHANNEL_DURATION

    case NL80211_ATTR_MESH_SETUP

    case NL80211_ATTR_WIPHY_ANTENNA_AVAIL_TX
    case NL80211_ATTR_WIPHY_ANTENNA_AVAIL_RX

    case NL80211_ATTR_SUPPORT_MESH_AUTH
    case NL80211_ATTR_STA_PLINK_STATE

    case NL80211_ATTR_WOWLAN_TRIGGERS
    case NL80211_ATTR_WOWLAN_TRIGGERS_SUPPORTED

    case NL80211_ATTR_SCHED_SCAN_INTERVAL

    case NL80211_ATTR_INTERFACE_COMBINATIONS
    case NL80211_ATTR_SOFTWARE_IFTYPES

    case NL80211_ATTR_REKEY_DATA

    case NL80211_ATTR_MAX_NUM_SCHED_SCAN_SSIDS
    case NL80211_ATTR_MAX_SCHED_SCAN_IE_LEN

    case NL80211_ATTR_SCAN_SUPP_RATES

    case NL80211_ATTR_HIDDEN_SSID

    case NL80211_ATTR_IE_PROBE_RESP
    case NL80211_ATTR_IE_ASSOC_RESP

    case NL80211_ATTR_STA_WME
    case NL80211_ATTR_SUPPORT_AP_UAPSD

    case NL80211_ATTR_ROAM_SUPPORT

    case NL80211_ATTR_SCHED_SCAN_MATCH
    case NL80211_ATTR_MAX_MATCH_SETS

    case NL80211_ATTR_PMKSA_CANDIDATE

    case NL80211_ATTR_TX_NO_CCK_RATE

    case NL80211_ATTR_TDLS_ACTION
    case NL80211_ATTR_TDLS_DIALOG_TOKEN
    case NL80211_ATTR_TDLS_OPERATION
    case NL80211_ATTR_TDLS_SUPPORT
    case NL80211_ATTR_TDLS_EXTERNAL_SETUP

    case NL80211_ATTR_DEVICE_AP_SME

    case NL80211_ATTR_DONT_WAIT_FOR_ACK

    case NL80211_ATTR_FEATURE_FLAGS

    case NL80211_ATTR_PROBE_RESP_OFFLOAD

    case NL80211_ATTR_PROBE_RESP

    case NL80211_ATTR_DFS_REGION

    case NL80211_ATTR_DISABLE_HT
    case NL80211_ATTR_HT_CAPABILITY_MASK

    case NL80211_ATTR_NOACK_MAP

    case NL80211_ATTR_INACTIVITY_TIMEOUT

    case NL80211_ATTR_RX_SIGNAL_DBM

    case NL80211_ATTR_BG_SCAN_PERIOD

    case NL80211_ATTR_WDEV

    case NL80211_ATTR_USER_REG_HINT_TYPE

    case NL80211_ATTR_CONN_FAILED_REASON

    case NL80211_ATTR_SAE_DATA

    case NL80211_ATTR_VHT_CAPABILITY

    case NL80211_ATTR_SCAN_FLAGS

    case NL80211_ATTR_CHANNEL_WIDTH
    case NL80211_ATTR_CENTER_FREQ1
    case NL80211_ATTR_CENTER_FREQ2

    case NL80211_ATTR_P2P_CTWINDOW
    case NL80211_ATTR_P2P_OPPPS

    case NL80211_ATTR_LOCAL_MESH_POWER_MODE

    case NL80211_ATTR_ACL_POLICY

    case NL80211_ATTR_MAC_ADDRS

    case NL80211_ATTR_MAC_ACL_MAX

    case NL80211_ATTR_RADAR_EVENT

    case NL80211_ATTR_EXT_CAPA
    case NL80211_ATTR_EXT_CAPA_MASK

    case NL80211_ATTR_STA_CAPABILITY
    case NL80211_ATTR_STA_EXT_CAPABILITY

    case NL80211_ATTR_PROTOCOL_FEATURES
    case NL80211_ATTR_SPLIT_WIPHY_DUMP

    case NL80211_ATTR_DISABLE_VHT
    case NL80211_ATTR_VHT_CAPABILITY_MASK

    case NL80211_ATTR_MDID
    case NL80211_ATTR_IE_RIC

    case NL80211_ATTR_CRIT_PROT_ID
    case NL80211_ATTR_MAX_CRIT_PROT_DURATION

    case NL80211_ATTR_PEER_AID

    case NL80211_ATTR_COALESCE_RULE

    case NL80211_ATTR_CH_SWITCH_COUNT
    case NL80211_ATTR_CH_SWITCH_BLOCK_TX
    case NL80211_ATTR_CSA_IES
    case NL80211_ATTR_CSA_C_OFF_BEACON
    case NL80211_ATTR_CSA_C_OFF_PRESP

    case NL80211_ATTR_RXMGMT_FLAGS

    case NL80211_ATTR_STA_SUPPORTED_CHANNELS

    case NL80211_ATTR_STA_SUPPORTED_OPER_CLASSES

    case NL80211_ATTR_HANDLE_DFS

    case NL80211_ATTR_SUPPORT_5_MHZ
    case NL80211_ATTR_SUPPORT_10_MHZ

    case NL80211_ATTR_OPMODE_NOTIF

    case NL80211_ATTR_VENDOR_ID
    case NL80211_ATTR_VENDOR_SUBCMD
    case NL80211_ATTR_VENDOR_DATA
    case NL80211_ATTR_VENDOR_EVENTS

    case NL80211_ATTR_QOS_MAP

    case NL80211_ATTR_MAC_HINT
    case NL80211_ATTR_WIPHY_FREQ_HINT

    case NL80211_ATTR_MAX_AP_ASSOC_STA

    case NL80211_ATTR_TDLS_PEER_CAPABILITY

    case NL80211_ATTR_SOCKET_OWNER

    case NL80211_ATTR_CSA_C_OFFSETS_TX
    case NL80211_ATTR_MAX_CSA_COUNTERS

    case NL80211_ATTR_TDLS_INITIATOR

    case NL80211_ATTR_USE_RRM

    case NL80211_ATTR_WIPHY_DYN_ACK

    case NL80211_ATTR_TSID
    case NL80211_ATTR_USER_PRIO
    case NL80211_ATTR_ADMITTED_TIME

    case NL80211_ATTR_SMPS_MODE

    case NL80211_ATTR_OPER_CLASS

    case NL80211_ATTR_MAC_MASK

    case NL80211_ATTR_WIPHY_SELF_MANAGED_REG

    case NL80211_ATTR_EXT_FEATURES

    case NL80211_ATTR_SURVEY_RADIO_STATS

    case NL80211_ATTR_NETNS_FD

    case NL80211_ATTR_SCHED_SCAN_DELAY

    case NL80211_ATTR_REG_INDOOR

    case NL80211_ATTR_MAX_NUM_SCHED_SCAN_PLANS
    case NL80211_ATTR_MAX_SCAN_PLAN_INTERVAL
    case NL80211_ATTR_MAX_SCAN_PLAN_ITERATIONS
    case NL80211_ATTR_SCHED_SCAN_PLANS

    case NL80211_ATTR_PBSS

    case NL80211_ATTR_BSS_SELECT

    case NL80211_ATTR_STA_SUPPORT_P2P_PS

    case NL80211_ATTR_PAD

    case NL80211_ATTR_IFTYPE_EXT_CAPA

    case NL80211_ATTR_MU_MIMO_GROUP_DATA
    case NL80211_ATTR_MU_MIMO_FOLLOW_MAC_ADDR

    case NL80211_ATTR_SCAN_START_TIME_TSF
    case NL80211_ATTR_SCAN_START_TIME_TSF_BSSID
    case NL80211_ATTR_MEASUREMENT_DURATION
    case NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY

    case NL80211_ATTR_MESH_PEER_AID
}

public struct nl80211_bss: RawRepresentable, Equatable, Hashable {
    
    public var rawValue: CInt {
        value.rawValue
    }
    public init?(rawValue: CInt) {
        guard let value = _nl80211_bss(rawValue: rawValue) else {
            return nil
        }
        self.init(value)
    }
    
    let value: _nl80211_bss
    init(_ value: _nl80211_bss) {
        self.value = value
    }
}

public var NL80211_BSS_BSSID: nl80211_bss { .init(.NL80211_BSS_BSSID) }
public var NL80211_BSS_INFORMATION_ELEMENTS: nl80211_bss { .init(.NL80211_BSS_INFORMATION_ELEMENTS) }

enum _nl80211_bss: CInt {
    case __NL80211_BSS_INVALID
    case NL80211_BSS_BSSID
    case NL80211_BSS_FREQUENCY
    case NL80211_BSS_TSF
    case NL80211_BSS_BEACON_INTERVAL
    case NL80211_BSS_CAPABILITY
    case NL80211_BSS_INFORMATION_ELEMENTS
    case NL80211_BSS_SIGNAL_MBM
    case NL80211_BSS_SIGNAL_UNSPEC
    case NL80211_BSS_STATUS
    case NL80211_BSS_SEEN_MS_AGO
    case NL80211_BSS_BEACON_IES
    case NL80211_BSS_CHAN_WIDTH
    case NL80211_BSS_BEACON_TSF
    case NL80211_BSS_PRESP_DATA
    case NL80211_BSS_LAST_SEEN_BOOTTIME
    case NL80211_BSS_PAD
    case NL80211_BSS_PARENT_TSF
    case NL80211_BSS_PARENT_BSSID
}

#endif
