List<LatLngPoint> decodeEncodedPolyline(String encoded) {
  List<LatLngPoint> poly = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;
    LatLngPoint p =
    new LatLngPoint((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
    poly.add(p);
  }
  return poly;
}

/// Note instead of using the class,
/// you can use Google LatLng() by importing it from their library.
class LatLngPoint {

  /// Creates a geographical location specified in degrees [latitude] and
  /// [longitude].
  ///
  const LatLngPoint(double latitude, double longitude)
      : assert(latitude != null),
        assert(longitude != null),
        this.latitude = latitude,
        this.longitude = longitude;

  /// The latitude in degrees.
  final double latitude;

  /// The longitude in degrees
  final double longitude;

  @override
  String toString() {
    return "lat: $latitude / longitude: $longitude";
  }
}

const strPolylines = {
  "Redoubt Rd - Te Irirangi Dr": "|~w`Fawlj`@cFpBcBp@{An@eGdCiGhC}H~C",
  "Upper Harb Hwy - Tristram Ave": "vzh_Fsdmi`@rCcCdE_EfDkDxDqEvDwErD{E|JmMnEuFzBiCxCqCvAoAfBuA`DwBrAy@jAm@`Bw@bBu@bBo@dBm@nF{AlEmAdBi@dBq@tCkApNcGlAi@",
  "Greenlane - Ellerslie Penrose": "`zc`Fya{i`@v@wAx@mA`D}EhBgD|BeE`HmMtAkCbCwDdDoE`AiArAsAfA}@~AcAbDyArOqGjGkCpCkAnAo@lAy@xAiAx@u@dAiAd@k@vAuBt@sAn@sA~@eC|@}Cj@uBdBiGl@oB`@oA|@mBl@iAjAaBx@_Ax@s@jA_AhBmA",
  "Harbour Bridge9": "xjy_Fqkpi`@cEeC}FiD}MuH{]iS_GeDuAq@m@SeAWk@Gm@Cy@@uAJ}BZaEv@m@FG?ICM@wAD{AIiBWgBa@}Dy@oDu@",
  "Harbour Bridge10": "x|t_Fwori`@vDdDrDpCjBjAbA`@bAZ|Bb@`Fr@xF|@bFv@`AF`AA`@Af@MzBSfBKfAO~@IlAE`AFdAPbAZ`Ad@~EnCfNbIv^~SpMpH",
  "East Tamaki Rd - Te Irirangi Dr": "rnr`F}yhj`@bCqDlDcFzA{BbBaC`DqE`K}NvJsNtCcElAyAx@w@p@k@|@m@~@i@`Bs@fBg@fBc@rFoAjPsDrFsAhEyAjFuBvEqBzMoF",
  "SH1 - Green Ln": "~t``Fgqvi`@rF`AfEl@vF~@lEp@jCd@b@H`@FD_@Hw@NwAVcCl@gHJyADg@RBfALdALbCZtBXv@FfADlCHzFNnGPxEJjBF~AH|F`@vBNhBThCXpAJjFj@zIz@",
  "SH20 - Mt Albert Rd": "~cj`F_iui`@h@PVRh@Vh@VXCTMJ?FDFJBNEXGHKDM?QOM_@GI_@Sa@QQIc@GW?M?EJMHI?KG{@WYOQCc@IgBe@gBe@c@Ia@EkBKgG_@wAGgAIgAKcCWaBQqFq@aFk@}HaA",
  "Airport - Montgomerie Rd": "d{y`Fepyi`@xAo@`Ae@`Cw@dAWR?~Ai@x@[AO@ODIHGJ?PJDXITODSGCEAAa@Na@NcA\\QFILQJs@b@aA`@cA\\y@XuBz@{FdCeDtAcBr@cAv@CJGDUBECc@Je@Lg@Te@XiBz@aAb@eCbAqAd@kARkADsAEe@I_AMkAUkB_@gAGkA@iBP}CVqBHmCR}Gh@uGd@mCTgALeARgBb@qEnAyAd@eATcALo@D",
  "Oteha Valley Rd - Upper Harb Hwy": "|pb_F{pji`@zD}AvE_B|Bm@~Bk@dCi@lCc@hBWvBWxF_@|Nq@|BGpBMdDa@nEw@|Bo@jBo@hEeB~EgC`JcEzDyAnBo@hCs@|EaAbCc@lCa@hB[rBa@vEwA~D}AtFsC~A}@|BwAvEyChCcBdD_CxAgAvBcBrC_C",
  "Tristram Ave - Esmonde Rd": "t~l_F{mpi`@zDaBfEmBdD_B~FaDtLmGbNqHbMuGhNuHzMgHpLoGlEaCfF_DtAaAbBqApDuCnAgAxA}AbEcEfD_DxAwAlBaBbBiA~@g@rAk@rAa@v@Q",
  "Tristram Ave - Upper Harb Hwy": "~~l_Folpi`@mNbGcEbB{EbBkMxDeBj@eC`AcEnBiE`CyA~@cBlAaBpAuApAiClC{CxDkE|FyCzDgEdFaCzCgBzBiBvBcDnD{D~DeD|CyBnB",
  "Esmonde Rd - Onewa": "xjr_Fsati`@r@OjBOfACjBDhBRdAPdB`@hCv@hDhAnAb@xAp@bBz@~A~@xCrBnDvCdFxErJ`JlE`E`ErD",
  "Esmonde Rd - Tristram Ave": "nkr_Fs`ti`@mAZyAb@eA`@{Ax@u@j@_BxA}DpDaKzJaDtC_EzC}DhCkFxC{LvG_B~@_ClAsE`CaG~CaCnA}A~@_G`DaG`DoEdCaFdCaFjC_CnAaBt@yDrBqDlBaFhCeF`CeBt@",
  "Royal Rd - Lincoln Rd": "|ux_Fqjxh`@tCY|Ge@`OgAxFg@hB]pA]jAa@`Bw@~@g@|AaAz@s@rAqAfAkAt@aA|BqD~DkGnJ{NjDmFhAeBnAgBtCyEx@{A",
  "Stafford Rd - Esmonde Rd": "fuu_Fw}qi`@eDy@uAo@gAk@{B{A{AeAuBcBiE}DeFwE_D{C}EmE{DuDeEuDqDwC}AaAmBiAaBy@gAg@iAc@yAe@iCw@iCq@}A]qAOc@C{@CwA?{AHmAPC?",
  "Te Atatu Rd - Rosebank Rd": "tu}_Fyu~h`@lEiPfB}GnBgHhF_RdBeGb@qAh@gAhAoBnAkBbCqCbAu@|BwA|A}@vAw@jAu@hAaA\\[j@q@tAgBz@yAfA{BjByDjC_GhCeGzFkN`AyBt@gBl@iBT}@",
  "Lincoln Rd - Te Atatu Rd": "fz{_Favzh`@tCqGrBcF`CmGbAcCr@{AxCiHxCmHtFyMbCiGvBsGrBwGvBwHnFgRfBkG",
  "Upper Harb Hwy - Oteha Valley Rd": "l{h_Fadmi`@_CnBqElDuFzDyExCgEfC{BvA_Bz@eEnBkAf@}Bt@eBf@kCj@cF~@yDl@sFjAwBf@gCx@cEzAkDzA_CnAkE|BwBfA}Al@aBj@yA`@iCl@sB^kBRiBN{FZ}GX}ERuE^{ALeC\\sF`AuFtAiErA_EzAa@N",
  "St Lukes Rd - Newton Rd": "p|_`F}cmi`@JoFEkCK}Ba@{Ew@{HOkBMcCAGEo@AeC@{ADgCXqIbAiU\\kHPaH@cCGeCSeC]aC]mB_@}AiAaD_AwBw@sAy@kAyDqEkDaEwCgDcDyDcIeJ",
  "Rosebank Rd - Great Nth Rd Waterview": "bl``Funci`@ViATuAVcCNcCFgC@cDP}HHeFAyHOaTEgJIyHE}@?y@AsDCsH@{C@w@Dk@@gC@qDD}GHyBTwCp@eGToBLmBDwABgC?{BKcBSwB",
  "Great Nth Rd Waterview - St Lukes Rd": "dr``Fqaii`@McAo@gD]sBSyAQaBKmBIuFCyAAo@Ee@UcC_@aCqAiH_BaIyAwH_@yBq@iDcBoIUuAWwBK_BGeC@cCHeDP{HJcF",
  "Newton Rd - St Lukes Rd": "lt~_Fyvri`@x@bBbAhB`@p@HThA`BxDnExDpEfHlIlA|AfAdBz@`Bj@rAr@tBV~@\\dB^`CTbCHxADxBAxAWxH_@bJ_@hIa@bI]rHExA?`DDrCDxANdCn@rGh@vFL`CFlB?fCAvACdC",
  "Grafton Gully - Newton Rd": "bw|_Fyovi`@jChCZZJRPVt@xAd@lAbAzBl@jArAtBp@~@v@x@vBhBrB~AxB|AfFtD|DvCrAdAx@r@r@|@j@fAb@lAXrAN`B@xAGxAOvAYpAaB`GGVEn@Gv@ExABhAPtAXdBv@zEh@~AfA|Bt@pAtAnCvAvC",
  "Rosebank Rd - Te Atatu Rd": "|l``Fooci`@c@rAu@tBgCfGsBbFuCpH}BtFwCvGgBvDaAfBiAbBmAzAoApA}@v@}AbA{FhD{@j@eAz@u@x@q@~@}AfCy@dBi@vAmB~GuBjHoBlHcFrQ{DfN",
  "St Lukes Rd - Great Nth Rd Waterview": "p}_`Fucmi`@a@tRCbCDrDJ~B\\lClAxGvAdHzDpRtAfHr@pEPnBHxAJxH@d@H^Ej@D`AHhAPxAdA`G^vB",
  "Great Nth Rd Waterview - Rosebank Rd": "|r``Fwaii`@NdAPbCHrE?dBIdCOdCUbCUbCOdCQbCKdCKzGElI?dAAl@EfB?zGLrRNfTDfJAnGUfTMdCSzBYjBa@nBKb@",
  "Te Atatu Rd - Lincoln Rd": "pv}_Fcv~h`@sFfS_BxFoBrGcC~HmCvHuBvFwBjFqG`P}GrPwCfHkAvC_AlBmAdC",
  "Newton Rd - Grafton Gully": "fr~_F_tri`@cAkAEOi@q@gB}Bm@{@Wc@g@oA]aAW}@SiAOwAK{AAyA@oDDwAH}@\\sBPy@JU~@aDZkAFg@JmAFeAAyAGgAQmA[mAYs@i@_Aq@y@a@_@mAu@oBcAw@c@}@m@{AeA}AiAsAmAaC{BkAoAsA_B}C}Dq@oAw@aBwAmDQe@Wa@o@_AqCmC",
  "Lincoln Rd - Royal Rd": "j{{_Fgvzh`@mCvFaCbE}@pAwAhBmBdCoJlN_IrLeBbCo@t@u@r@s@l@{@n@mC~AoChAqA`@aB^aBRoCT}Gj@eCR_CN{Gj@iDX",
  "East Tamaki Rd - Princes St": "for`Fgyhj`@_DnEcEdGcB`CqA`B}AdBq@j@wA`A_Bz@gEdB{NlGq]dO{LpFoAj@oBv@gFxBgFxBwDzAsAf@qA\\_C^uAN_Fl@{G|@qEl@",
  "Te Irirangi Dr - East Tamaki Rd": "jwv`F}blj`@uNbG{MlFmDfAsBh@iB`@uGzAuGzAuG|AcB`@gA\\{Al@}@h@eAt@y@r@w@v@u@z@mDdFkKhOkKhOkDdFmD|EoGdJ",
  "Takanini - Hill Rd": "ls`aFybqj`@oNB_H@qGHgOD_QF_QDoC@kBDsALkAPeAVsAd@_A`@}@f@aB~@}FhD}FfD_B|@aClAgAf@",
  "Hill Rd - Redoubt Rd": "fl|`F_jpj`@kOnGoAh@}A|@oBxAsAtAo@v@kAhBeDhGyIdP}@zAkA~Au@z@sApAsAhAyB~AuF|DkM~IsDpCwE~C{DnC}@j@_Ah@yBdAyErBkGbCwEjBcFvBi@V",
  "Ellerslie Penrose - Greenlane": "hyg`F{r_j`@iDbC{@t@_AbA{@fA{@vAk@fAo@bBgAnDmBbHw@rCk@dBy@rBi@fAaAdBiAbBm@t@y@z@wBlB}@n@mAr@cAh@yB|@{ErBuOpGcCbAqAn@u@b@{AdAuArAiApAeC`DkA`BeAdBeCpEoDzGkDnGqBtDcAhBgAbB}AxBq@lAe@z@",
  "Princes St - Mt Wellington Hway": "`um`Fmafj`@gAPgB`@sGhBcOfEi`@zKePtEiGdBgCt@eBj@aA`@_B~@iBtA{@~@aAnAi@v@U`@}@nBw@pBwBtGqAtDqDvK",
  "Mt Wellington Hway - SE Highway": "tvi`Femcj`@mEzMq@vBm@xBYtA_@|Bc@rCOrA",
  "Greenlane - Gillies Ave": "rzc`Fw`{i`@{@nBw@rBoCvHeCdHy@pB{@nBaCvEkApB{AvBeAtAy@~@ETMVgAxAaAfAcB`BmDnD_@^Vf@v@rAjAvB{AfAyC~BoDpCiEhDy@`AgB|BiDzEoD`FiE|FgA`B[n@Gj@YxC_@nDw@bIE`@E?eAQuBYkF_As@O",
  "SE Highway - Ellerslie Penrose": "xii`F{hbj`@iHxe@aA~F]`B]fAc@rAk@tAy@`Bw@jAs@~@oAnAoAbA_BdAyFpDiFlDmChB",
  "Harbour Bridge": "x|t_Fwori`@vDdDrDpCjBjAbA`@bAZ|Bb@`Fr@xF|@bFv@`AF`AA`@Af@MzBSfBKfAO~@IlAE`AFdAPbAZ`Ad@~EnCfNbIv^~SpMpH",
  "Gillies Ave - Greenlane": "js``F_rvi`@}@`BuAnBu@z@qCxC}BjCwBnCaB`CgAbBiA|AAVGRSb@[d@kArAy@p@}At@}Ad@wAZaBRG@E\\M`AKx@~@VfCp@L@x@W_A}FOc@[e@y@{@a@OGd@FVCPBPPNFFHCTOLIl@W|Ak@`Ae@r@e@fAaA~@cAlAaBTOZc@dA}A`BaClBqCbBgBv@w@jCkCt@{@hA_Bl@aA~@sBx@qBr@uBzBcIl@yBr@uBt@aBf@w@v@iAbBoBvAoAtBgBlEyD~EgE|AwAnBqB~EaFfJoJ~EaFhAoApA_BhDgFdCqErAqCz@oB~BeGlCyHhBgFd@cA",
  "Nelson St - Gillies Ave": "tc}_Feesi`@~@Ml@El@Ab@@`@Fb@J`A^nAf@~@d@d@T\\HdANv@Ap@KvAe@`@ObAYl@I`@Q\\WX]Vc@Ta@Na@Ji@Dm@BkBIeA[aCEwA@m@Bk@NoALq@N}@~@aDZkAFg@JmAFeAAyAGgAQmA[mAYs@i@_Aq@y@a@_@mAu@oBcAw@c@a@KaB{@}BsAeBcAuBsAoA{@uAoAo@k@IQ|@o@f@U`@M`@G`@GN?H^Nd@Tb@|@p@nA~@vDnCz@n@R\\rA~@fAv@vAjA|AvAx@~@j@x@|@|Ap@~@\\Z`@Rn@Rn@Hx@Cv@Ub@Y~@{@dAkBXc@V[RQLURYd@u@|@_Az@o@fAe@fA[xCu@hA]`Ae@x@g@x@q@z@aAbAwAlAsBp@_A`EcG`@k@jAoAhCmCx@w@jAqAlAaBh@}@p@uAx@qBv@sB|@aDvB{Hj@gBz@mB~AcCnA{ArAsAjFkEvKqJ|LaMhJqJ|DeEnAwAbBaClCiEvC{FtB_FfAsCDi@Pi@n@wBp@wBx@_CZu@Ty@Lo@Fc@Ae@J[PSTGNBJFRRFLRr@@PARKVQTQHE?GLQVQ`@k@zAgAzCiApCy@pBINIDI@c@lAw@rBy@pB{@nBwAlCcAfBqCdEcAlA_AdAqAvAoBnBcEdEaEfE}EbF_E~DcFxEoDzCcFtDq@n@}@~@u@|@}@rAa@n@m@rAw@pBw@jCa@tAqBnHmAbD_@x@KPQ\\",
  "Gillies Ave - Hobson St": "xs``Fsqvi`@XLDXO\\_@d@qAvAgAbAgAx@q@b@a@TG@[\\k@l@w@~@s@z@cApAiA~A_DtEeCdDu@x@y@l@o@`@}@^y@XoBd@{Ab@gAb@u@d@i@d@aAfAeAzA}BbEq@x@cA`AiBzAoAjAo@t@o@bAi@fA[bAY`A_@`BSvAMxAI|BErCI~AOnA]jAm@xAw@fAgAz@_@R}@^oAd@cA\\_Bd@YD",
  "Cook St - Nelson St": "fc|_Fcpri`@rAWrAa@rAm@r@_@h@a@rAkA`BuAtAoApB}AbAs@l@_@~Ao@p@Up@M",
  "Hobson St - Wellington St": "|t}_Fi~ri`@q@BgAEw@MqAe@kAi@y@]y@Mm@Eq@@qAPk@N_Af@{AhAKNSP",
  "Shelly Beach - Cook St": "~jy_Fompi`@v@^|A~@~Av@nAf@^Xb@D~@B\\?j@I|@UbAo@fAiAj@w@|@_BdC_Fl@iAl@y@d@g@p@e@|A_AlAw@XWRWf@y@Rc@XeATuAf@mDx@wE`@kAj@wApC_Gx@}Ap@gAn@s@t@k@l@[v@UdAQjAGrGMvACjBK`AMXI",
  "Wellington St - Curran St": "~y|_Fc}ri`@cEbDyAfA{AfAmAx@}B`AcA\\eAVaB\\y@NsDLkBBaBAm@@c@Fa@Hk@PWJc@Ri@X]Xe@d@i@p@w@nAyAlCwAjCm@vAg@lBa@pB_AvGYdAk@rAe@p@_Az@cDpBk@b@k@p@cAhBuAlCaAjBsAvBy@`Ag@b@]Vg@Ry@RgAJkAA[CU?o@Q_By@mBeAcBcA",
  "SE Highway - Mt Wellington Hway": "fii`Fkjbj`@x@mFb@_C\\}An@yBdA}ChC{HLa@",
  "Ellerslie Penrose - SE Highway": "pxg`Fos_j`@pLcIpE}CtB{A~@w@|@_Ar@_Av@mAv@_Bf@kAl@kBZmAh@mChAkHpAyIdAgGhAkHp@iF",
  "Redoubt Rd - Hill Rd": "r~w`Fcxlj`@bKgE`NwFbBs@nB}@~A_AzAcAfEyCtEcD`BgA|@u@jEwC~LwIxB_Bx@s@tAsAz@aAxAsBx@qAlC_FbJuP~@}ArAgBrAsAz@s@hAw@rAq@lEsBjKqE",
  "20B Puhinui Rd - 20A George Bolt Mem. Dr": "nvw`Fakcj`@uC~DeB~BmA|AuDvEsDvEiKjMgLfN{HjJ{CvDyCbEoC`E{CzEiDdGqDxG}InPiHrMyCxF}BxEyHfQ{GbO_IrQ}GnOoB`E_AxAoAhBiArAsAtAyBlB{BzA}Az@mBx@qFvBgEdBcBp@a@PSBUCaA`@eCdAiGhC_GbCcCbAwBv@cEtAaD~@aCn@}Bf@kCh@wE~@iGzAuG|AeN`DiP`EmN~CuE`AoEhAkMjDgBl@cBt@aBx@_@Ri@`@iBxAu@p@mApAkA|Ao@dAu@pAoArCcCjGwBxFwCpHmCnHuBtFuC~GaDhHiCdGw@rBYt@Kj@i@zBk@vBwA~GoA~Fm@nCI`@HHFXANGJQHQCMQSc@sAo@m@IW@KNODIAKIEWFSNIn@@b@QZS^g@r@iBjB_Gd@uAh@_ATo@~@uCdAyCxBgFdCmFfCiGzBwFlAuCv@sBtBcGrCuH`CmGhCgGjCmGnAoBpAeBx@}@z@u@bBsArAw@rAs@bBw@nBq@fBc@xEqApD}@hBg@fBa@bB]pA]dFiAtEcAtOqDfOqDbOmDlMqCfAQl@Qp@SnGsBfC{@vAk@vE_BfC{@rAg@~Au@bCcA|CyA",
  "Hill Rd - Takanini": "zk|`Fikpj`@fD_B~FeDjF{C`EeCjBeAlAg@v@YdAYfASdAKdAGjBAvEAnCAdNE~YGxAA~ADlFA~PEjD@",
  "Mt Wellington Hway - Princes St": "pui`Fmlcj`@~Ky\\d@kA|@mBl@aA~@oAz@_A~@{@zAgAvAu@jAe@fCw@~FcBlMqDha@iL`OeEfGeBpFyA~A[",
  "Princes St - East Tamaki Rd": "ztm`Fmbfj`@|Eq@nFq@dBOlC_@tAOhB[pAYdBk@zFgChGkCbCgAbBo@pD{AvBaAbCcAhGkC`GiCfNaGhN_GfGiCbBw@|@k@z@o@vAoAlA}AnAeBlCaEjC{DlCsD",
  "Queenstown Rd - Dominion Rd": "bgj`Fegui`@PF^RTABANIHCH@HHFL?JX\\PRt@RhCt@bAXRD@EBEF?FHAF@XV`CPrB?PKZc@lA}@nCeA|CmBbGcA|Cm@~Ai@fAo@`AyDrFaB`Cq@`Aa@g@m@k@_@Sa@Mq@@eBA_BOqAtFk@bBy@~AcDvFg@b@i@fAi@hA[x@_@dAe@rAm@~Be@|Ba@`CU`CQdCMrDMpDMdC_@xDYxBa@~Bi@zB}@`DQn@Eh@]hAe@zAu@rBiBxEw@rBe@jAeAUIC",
  "20A George Bolt Mem. Dr - Queenstown Rd": "plq`Fee{i`@hDeBzBwAzAeA|EoDxEkDpF_ExBaBfB}AbAcA|AeB~@oAhAcBdAeB|@gB|BaFbIsQ~HuQdC_GBWDQjAwCnCuGdAaCb@y@dAnAmA|B_DvFcCtEQJg@jAoAtCeCvF_DbHmHnP{GnO_D`H}ApCaBbCs@|@qAvAiAdA{BdB}@l@_B|@aBt@cBp@kFvByEjB{@\\UAGAa@NaAb@aA`@eCdAiGhC_G`CcC~@cA^mEvA_Bd@}@TeDx@wGrAsAV}Bf@oG~AiOlDgOrDwFtAsFlAiMnCiFtAyF`BgBb@qAb@cBp@qB`A{@f@uBbBcAz@}@|@gAvAy@lAgBdDeBfE_ClGoGjP_CpGaCbG}CjHoCdGeChGc@hAI^e@lBsAtFwA~G}AfHQr@FDFJBNEXGHKDM?QOM_@GI_@SQG",
  "Dominion Rd - Richardson Rd": "reh`Feyoi`@j@Lb@JCBe@jAg@jAo@hBm@fCuAfHc@~BU|@Uh@GHOh@o@vBgAvCy@nBeDfHaD`H_CfFcB|D{H`PsC~FqBvE{B|E{@nBy@tBiAjCw@`Cm@xBe@zBoAjHoAhHg@hCw@xCq@tBmAvCkCdGy@`BgAfBaB~BgBzBeDjDuApAoB|AcEjCwBlA}At@wAj@}Bt@gBf@aCh@yDn@uP~BuNrBiBTkBN}Gh@uEJoC?kBGoCOi@Ek@IcC]iB[uB_@eAS_@OqBc@mCc@sFkAuAa@uAu@}@y@s@aAs@_Bc@eBQoBKeCK_F@sFC}AEg@Hi@UcC_@aCqAiHyDyR_@yBq@iDcBoIUuAWwBK_BGeC@cCHeDP{HDgCIk@EmAAeBAeCKsDKwAOg@OS_@][MOEQJKJCHCVL~@Z`AT`BH|AFvALh@JjAN`@HXZBvANb@FBBWnDi@fIMdCCr@K`@CJ?j@BxAHjCVbCZpB~ArIxDhRzAjHhAlGVdBN~AJvAF~CBfCDxANp@DXXtCXbBj@rCh@hBRj@`@v@x@bAXZ^Vb@ZbA\\~@b@b@TdARjCf@jCd@vGlA|Gl@tEXjB?jBCtBIbCO|Gg@jBQlCa@lG}@xG_AzGcAtF}@fCg@jBg@dBk@`Bo@bBy@|BsA~BwAxAeAxAkAtAsApAuAnA{AnAyAhAaBvAuB|@}A|@aBpAqCx@sBr@sBdB_Hd@}Bd@}C^qCd@uC`@gBj@qBr@uBt@sBvCeHdCuFpAsCz@{BbAiB~@mB`DgH|AeD",
  "Te Irirangi Dr - Redoubt Rd": "~vv`Fyclj`@fLqEpEuBxB{@|@_@~FaC`EcB",
  "SH1 Southern Motorway - 20B Puhinui Rd": "pux`F{ilj`@_CIWDy@EaACm@AsAFeAJc@Hg@NcAd@I}BY}Ba@iC{@qFMm@XAzAOd@Gn@QhBq@zBu@tAUd@?b@Dr@Nd@P|@l@j@j@PXT`@Rf@XlAJrBIdCWhFGhDCj@EZ?f@?xAAxA?rD@zHHrGVzHLpDLdCd@|GzAdTnCph@d@bJPrDHdCVxHZdJLbDBvCKfII~BM|BYpDUpBi@jDc@~Bu@dDm@xBaA~C_AfCcAdCo@tAaAjByAhCiAdBiA~AwDhFcEzFyIzL",
  "Dominion Rd - Queenstown Rd": "zeh`Fkyoi`@h@yAfAgCdDeHhAyC|@gCb@yAZuA^mB^aCXaCXqDHqBPmGFwAPeCVcCZmB\\eBj@{Br@uBf@qAbCaFrAqCz@oBd@uAh@qBh@}BRuAl@wE|@qG^qBj@{B`@mAf@kA~@kBbDoFdAiBbAsB|@_Cj@iBfAoD",
  "Richardson Rd - Dominion Rd": "nbg`Fyjmi`@nBiEz@oBdAsBhA{B~@sB~AmDpC_Gz@oBn@aBlAwDXaAZsAd@eCf@wCb@yCh@oCn@{B`AaD",
  "20B Puhinui Rd - SH1 Southern Motorway": "vuw`F_lcj`@jJwMzDqF^k@vAoBnDcF|AeC`AeBfA{Bl@cBtBiGjBcHZsATuAf@kDXsBZoDNeCHeCBmC?wCKyHUiH[sI_AuRcA}Sg@eJMg@Ik@WcCa@_D]aBm@mBm@{AaAqBm@kB]u@[gAa@aBWaCMeCOaDWcCWaB]aCq@gDg@qBm@yBk@eCwAeGk@{BOq@Ik@KsBCsBCc@ZM`@Kv@S|@S|@KtAClBHh@HNRfADv@B",
  "Montgomerie Rd - Kirkbride Rd": "ddv`Fupxi`@aBCeAIk@KoAYuAm@kBeA{DaC}BwAaBw@oAk@c@Ca@KcBo@cC_AgBk@eBo@iBk@u@WaAa@{BaAOML[\\o@`@u@",
  "Kirkbride Rd - SH20": "vlt`Fopyi`@fFkKZiAd@_CxAyHlAoGNm@?{AOiHOwGGyCDeAReAf@eBxBqGzBcHl@iBXkAJq@FwAAyAScCm@uH]kFq@uIM{@Uy@Wk@y@}AoD}G_D}F}@wAw@gAoCmDa@m@m@dAcAhBsDvGaAjBGFIDSd@g@jAg@hAgAhCkC|FcDhHkHnP{GnOeCjFy@tAiAdB{@hAgAnAuApAy@r@eAx@_Al@KH",
  "Montgomerie Rd - Airport": "ddv`Fupxi`@aBCeAIk@KoAYuAm@kBeA{DaC}BwAaBw@oAk@c@Ca@KcBo@cC_AgBk@eBo@iBk@u@WaAa@{BaAOML[\\o@j@eAl@XbB`ApFxC|EpC~A~@XZb@X`B|@~Az@~ErC~EjCbA^~@Tz@NfAHl@@zAEl@C~@KlA[jBk@lFwAzB]lJy@fE[tE]zAM~@IRAZQz@Kp@E|AInBGfAFlEx@rATp@H`A@r@C|@Kz@UvB}@pCqAjD{At@o@HMLGR?xA[pDeBjCqAxAu@pBw@@A",
  "20A George Bolt Mem. Dr - 20B Puhinui Rd": "plq`Fee{i`@hDeBzBwAzAeA|EoDxEkDpF_ExBaBfB}AbAcA|AeB~@oAhAcBdAeB|@gB|BaFbIsQ~HuQdC_GnCaGrC}FxCyFfCoEvAaCtAgCnDuGpD{GzCuFhCoEdDkFrCeErD{EnDkEdLgNfLiNpEuFfEoFjDsElAmBjA_BvCaE",
  "Queenstown Rd - 20A George Bolt Mem. Dr": "bgj`Figui`@jBsGhB{Gv@oC~@uCdAyC|@uBxB_FfA_Cx@qBpC{Gv@sBlAuClBgF~@oChA{C`CmGbCkG|CkH|@wBnAoBpAeBx@}@~CiCrAw@rAs@bBw@nBq@fBc@fBg@zEqApD}@jE_AlD{@rFmAtNeDhOmDfOqDrFoAbGqAzA]fAQl@Qp@SfCy@nGuBfDoAnGwBrAg@~Au@bCcA`Bw@z@a@",
  "SH20 - Kirkbride Rd": "thr`Far{i`@}Az@aBt@iFtBgEbBsDxAUAGAa@NaAb@aA`@eCdAcCbA_GbCeCbAaA`@_@N]Vk@d@q@ZaBt@wAp@o@n@OTMf@Mv@?VA\\Hr@Rv@Zv@b@dAXf@FJB?H?NLDHj@`@dAd@fBp@pBz@pBx@nFrBvEfB~D~AlG~BhNhFdMtE|DvAdCt@\\Nd@EnCOdF]tF]f@G`AW~FkB|Ac@z@[\\GJa@^u@|AeCpAqCt@{A`@u@",
  "Kirkbride Rd - Montgomerie Rd": "vlt`Fopyi`@HOLFb@T~BpA~ElCnF|CjAr@PX`Af@~A|@~Az@~ErC~BpAhAj@`A\\|@PjAR|@Dz@@rAGx@EhASfEmAzC}@z@QjBWrJw@tE]xDYnBQv@GZQBh@BpA@nA?hA?h@C~@QzBDt@BDFTAVKPODSGIMCUDULMLwAJmB@eA?yAC{@C[OYGI_@Oc@GeAHoCR}Gh@uGd@iBPeANeATiCr@qDbAwA`@eARqAJ",
  "Mt Albert Rd - Green Ln": "rbh`F{tui`@sDu@uEcAcFeAyEgAgNwCmFmAaB[kCk@sGsAsBi@eASoFiAeGqAYCm@@mBFu@BQAcBWkE{@i@Ko@Eo@I",
  "Green Ln - Mt Albert Rd": "jvd`Fgsvi`@~ANtAV`B\\rB\\~@LzAEtBGXBt@NhCj@xBd@zBf@hB\\`B`@rBb@rGtAjFfAnFjAzEdAhGtAzEdA~Dx@fJnB",
  "Campana Rd - SH20": "`my`Fuu`j`@q@sC]eBy@eG]{B[sAOk@Uc@a@kA}@qBo@wAg@uAYeAKi@Ec@Kg@[sAYsAg@{By@eDWeA_@aAc@gBaBwGoBkIw@cDy@yCa@oAUeAe@uBqAcF[sAPSH\\Rt@VdANl@IH",
  "Green Ln - SH1": "jvd`Fgsvi`@oMqAwBUqAKsFo@sFa@aCO_BIwFO{EMkOa@gAEw@GuBYqGw@gFy@wFs@_BWk@Ic@MSMGj@YxC}@|IYtCE`@E?eAQuBYoB_@iCc@",
  "Mt Albert Rd - SH20": "vbh`Fytui`@hEj@fEd@vM|AxFj@nETnG^`AJvA\\hCr@v@LfA@D@@EDGPGJ@JHF@",
  "SH20 - Campana Rd": "phx`F__dj`@GFK_@Mi@k@{BPSH\\Rt@f@rBvAtFpA`GdEdQpAnFj@zBd@vB`B`Ht@fDh@xBXz@h@pAbBfEd@rARv@VdAVrA`AjHVtAf@zBZrA",
  "Airport - Campana Rd": "b|y`Fqpyi`@nBaApAe@|@YdAWR?r@WdBm@AO@ODIBCGWUq@c@mAY{@GUMQy@q@_Am@g@m@KQO[Us@k@oCe@aCSg@KGGM?UBGCKSuAE_@?KKi@WuAWsAo@iDo@iDc@_CEwAAo@Di@Lk@Xi@\\[RMt@WbA]TQNUVaAGi@Gg@KWm@PYNa@VQLM?OMCWDQBGKi@OcBAaBDeCHgJ@m@Dk@?uCA{H?eDDeCFuHD_BJ}AT}BRuAvAgIPuAHyA@qAAs@I}AY}Bg@}By@eDqBiIwEwRkCsK",
  "Campana Rd - Airport": "`my`Fuu`j`@xLbg@lB|HZhBRpBBzA@t@EvAMxA[pBm@hDa@~BWpBOhBGxAIxHG~F@zH@rD?z@Ej@EfCErDA`DChB@t@Hv@Rd@HVLTHBHRAVMNO@IACEc@FS?cAZgCz@gCz@_@PY^ILOVOt@FN?PCLIBEVAPHj@DXAPRdAJp@b@bCvAvH|C`QtAtHb@`CRtAHJd@xBj@tCFR"
};

Map<String, List<LatLngPoint>> getAucklandPolylines(){
  var list = new Map<String, List<LatLngPoint>>();
  strPolylines.forEach((key, value){
    list[key] = decodeEncodedPolyline(value);
  });
  return list;
}

final aucklandPolylines = getAucklandPolylines();
