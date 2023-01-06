import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/DQColor.dart';

class UserType {
  // 用户类型对照
  static Map typeEn = {
    'VIRTUAL_USER': 'VIRTUAL_USER',
    'GUEST': 'GUEST',
    'NORMAL_USER': 'NORMAL_USER',
    'CERTIFICATION_USER': 'CERTIFICATION_USER',
    'DQ_EXPERT': 'DQ_EXPERT',
    'DQ_SINGER': 'DQ_SINGER',
    'DQ_OFFICIAL_ACCOUNT': 'DQ_OFFICIAL_ACCOUNT',
    'ADMIN': 'ADMIN'
  };
  // 中文对照
  static Map typeCn = {
    'VIRTUAL_USER': '虚拟用户',
    'GUEST': '游客',
    'NORMAL_USER': '普通用户',
    'CERTIFICATION_USER': '实名用户',
    'DQ_EXPERT': '读亲达人',
    'DQ_SINGER': '读亲歌手',
    'DQ_OFFICIAL_ACCOUNT': '读亲号',
    'ADMIN': '管理员'
  };
  // 颜色对照
  static Map typeColor = {
    'VIRTUAL_USER': DQColor.un3active,
    'GUEST': DQColor.un3active,
    'NORMAL_USER': DQColor.un3active,
    'CERTIFICATION_USER': DQColor.success,
    'DQ_EXPERT': DQColor.info,
    'DQ_SINGER': DQColor.danger,
    'DQ_OFFICIAL_ACCOUNT': DQColor.active,
    'ADMIN': DQColor.warning
  };

  // 用户中文对照
  static String formEn(String userType) {
    return typeEn[userType];
  }

  // 用户中文对照
  static String formCn(String userType) {
    return typeCn[userType] ?? '未知';
  }

  // 用户颜色对照
  static Color formColor(String userType) {
    return typeColor[userType] ?? DQColor.un3active;
  }

  // 是否是虚拟用户
  static bool isVirtualUser(String userType) {
    return typeEn[userType] != null ? true : false;
    // return userType == typeEn['VIRTUAL_USER'] ? true : false;
  }

  // 是否是游客
  static bool isGuest(String userType) {
    return userType == typeEn['GUEST'] ? true : false;
  }

  // 是否是普通用户
  static bool isNormalUser(String userType) {
    return userType == typeEn['NORMAL_USER'] ? true : false;
  }

  // 是否是实名用户
  static bool isCertificationUser(String userType) {
    return userType == typeEn['CERTIFICATION_USER'] ? true : false;
  }

  // 是否是读亲达人
  static bool isDqExpert(String userType) {
    return userType == typeEn['DQ_EXPERT'] ? true : false;
  }

  // 是否是读亲歌手
  static bool isDqSinger(String userType) {
    return userType == typeEn['DQ_SINGER'] ? true : false;
  }

  // 是否是读亲号
  static bool isDqOfficialAccount(String userType) {
    return userType == typeEn['DQ_OFFICIAL_ACCOUNT'] ? true : false;
  }

  // 是否是管理员
  static bool isAdmin(String userType) {
    return userType == typeEn['ADMIN'] ? true : false;
  }
}
