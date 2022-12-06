class SwiperModel {
  SwiperModel({
    required this.banners,
    required this.code,
  });
  late final List<SwiperResult> banners;
  late final int code;

  SwiperModel.fromJson(Map<String, dynamic> json) {
    banners = List.from(json['banners'])
        .map((e) => SwiperResult.fromJson(e))
        .toList();
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banners'] = banners.map((e) => e.toJson()).toList();
    _data['code'] = code;
    return _data;
  }
}

class SwiperResult {
  SwiperResult({
    required this.imageUrl,
    required this.targetId,
    this.adid,
    required this.targetType,
    required this.titleColor,
    required this.typeTitle,
    this.url,
    required this.exclusive,
    this.monitorImpress,
    this.monitorClick,
    this.monitorType,
    this.monitorImpressList,
    this.monitorClickList,
    this.monitorBlackList,
    this.extMonitor,
    this.extMonitorInfo,
    this.adSource,
    this.adLocation,
    this.adDispatchJson,
    required this.encodeId,
    this.program,
    this.event,
    this.video,
    this.song,
    required this.scm,
    required this.bannerBizType,
  });
  late final String imageUrl;
  late final int targetId;
  late final Null adid;
  late final int targetType;
  late final String titleColor;
  late final String typeTitle;
  late final String? url;
  late final bool exclusive;
  late final Null monitorImpress;
  late final Null monitorClick;
  late final Null monitorType;
  late final Null monitorImpressList;
  late final Null monitorClickList;
  late final Null monitorBlackList;
  late final Null extMonitor;
  late final Null extMonitorInfo;
  late final Null adSource;
  late final Null adLocation;
  late final Null adDispatchJson;
  late final String encodeId;
  late final Null program;
  late final Null event;
  late final Null video;
  late final Null song;
  late final String scm;
  late final String bannerBizType;

  SwiperResult.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    targetId = json['targetId'];
    adid = json['adid'];
    targetType = json['targetType'];
    titleColor = json['titleColor'];
    typeTitle = json['typeTitle'];
    url = json['url'];
    exclusive = json['exclusive'];
    monitorImpress = json['monitorImpress'];
    monitorClick = json['monitorClick'];
    monitorType = json['monitorType'];
    monitorImpressList = json['monitorImpressList'];
    monitorClickList = json['monitorClickList'];
    monitorBlackList = json['monitorBlackList'];
    extMonitor = json['extMonitor'];
    extMonitorInfo = json['extMonitorInfo'];
    adSource = json['adSource'];
    adLocation = json['adLocation'];
    adDispatchJson = json['adDispatchJson'];
    encodeId = json['encodeId'];
    program = json['program'];
    event = json['event'];
    video = json['video'];
    song = json['song'];
    scm = json['scm'];
    bannerBizType = json['bannerBizType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageUrl'] = imageUrl;
    _data['targetId'] = targetId;
    _data['adid'] = adid;
    _data['targetType'] = targetType;
    _data['titleColor'] = titleColor;
    _data['typeTitle'] = typeTitle;
    _data['url'] = url;
    _data['exclusive'] = exclusive;
    _data['monitorImpress'] = monitorImpress;
    _data['monitorClick'] = monitorClick;
    _data['monitorType'] = monitorType;
    _data['monitorImpressList'] = monitorImpressList;
    _data['monitorClickList'] = monitorClickList;
    _data['monitorBlackList'] = monitorBlackList;
    _data['extMonitor'] = extMonitor;
    _data['extMonitorInfo'] = extMonitorInfo;
    _data['adSource'] = adSource;
    _data['adLocation'] = adLocation;
    _data['adDispatchJson'] = adDispatchJson;
    _data['encodeId'] = encodeId;
    _data['program'] = program;
    _data['event'] = event;
    _data['video'] = video;
    _data['song'] = song;
    _data['scm'] = scm;
    _data['bannerBizType'] = bannerBizType;
    return _data;
  }
}
