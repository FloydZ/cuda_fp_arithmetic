#define TESTS 16

#define LIMBS 8

#define limb_t uint32_t

__device__ limb_t __p[8] = { 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x5903FFFF, 0x2AC64089, 0x6CD84675, 0x4416F178, 0x037B545B };
__device__ limb_t __mu[8] = { 0x00000001, 0x00000000, 0x00000000, 0x59040000, 0x2AC64089, 0x6CD84675, 0x4416F178, 0x68B71C6B };
__device__ limb_t a[TESTS][8] = {
{ 0x36C19C68, 0x329D82AB, 0xCB35090E, 0x0D08F168, 0x4D9B2B80, 0x70C62270, 0x2AF8373E, 0x0347F33D },
{ 0xE63398C7, 0xCCC96199, 0x9E83E225, 0x723CAA3C, 0xC328D335, 0x1663FA33, 0xD7762EC5, 0x0200C9F4 },
{ 0xCD4F2600, 0x8714D282, 0x3B9F6344, 0x16E25C87, 0xB10DABF1, 0x41D4F42D, 0xF970A8FC, 0x0002AD27 },
{ 0x44AC576B, 0x601B4890, 0x59696453, 0x5B261F5F, 0x17F4CBEF, 0xD73356F8, 0x28F30E66, 0x02FA18BD },
{ 0x2EF6523B, 0xB8E5F2CB, 0x31DE0CE7, 0xC6C2B283, 0xEF08D262, 0xBBC307CB, 0x826A8659, 0x01237461 },
{ 0x381A5954, 0xAF91D402, 0xD5840DE9, 0xBF13F19B, 0x94B5D959, 0xE16D2EAC, 0x7A0002AA, 0x00BD3B7F },
{ 0xA5E805AE, 0x2873C405, 0x397D5511, 0xBDCF658D, 0xD11A97A1, 0xDEFA62E5, 0xC6312C60, 0x03553B52 },
{ 0x3EA5E488, 0x6447FD61, 0x7C737AE9, 0x0DCE5663, 0xDCAECB43, 0xEE6945B9, 0x17D4C985, 0x00EEC9B5 },
{ 0x8365D54F, 0xC6B99D8C, 0xAFBF2B31, 0x01E2F5D3, 0xAD695CC4, 0xF28AE4E0, 0x93E952D9, 0x0210AA1B },
{ 0xE4B059EE, 0x8B2BA02F, 0x332B75CD, 0x564C5A49, 0xA3CAFE6C, 0x24F567E9, 0x337455F5, 0x018BFB82 },
{ 0x7D06973B, 0x3B9CA164, 0xC697E19E, 0xB262755B, 0x78177128, 0x57339E94, 0x9853C6FB, 0x016EC593 },
{ 0x2771CBCC, 0x4D6DEE06, 0xB5C87E7B, 0xB3F4339D, 0xF115F618, 0x469555CB, 0xCB896A1E, 0x02C1C845 },
{ 0xEB7B40C9, 0x9DC8E1FE, 0x36D52698, 0xD2A70E5A, 0xCB8DA649, 0xB721C7F3, 0xB5E9F5CC, 0x00F887CA },
{ 0x24E109BE, 0x198A3087, 0x473BDE2E, 0xB3D904E1, 0x248B2500, 0x021EFA40, 0xBB4F65C0, 0x006B2AEF },
{ 0xA45368B0, 0xDBC424FF, 0x3323FEB5, 0xF329895B, 0xFE871856, 0xF2BCBEBD, 0xBCC4B3C1, 0x01728FC4 },
{ 0x886BE6CD, 0x368DB8A7, 0x3DCF082A, 0x0D6A5812, 0x3099050C, 0x6B02105C, 0x369444A1, 0x03513A31 }};

__device__ limb_t b[TESTS][8] = {
{ 0xAF10D443, 0x4335E652, 0x5FF3ADC9, 0xA51E2D96, 0x7160E93A, 0xFD5CE948, 0x6458982A, 0x0171561A },
{ 0xD6EE0790, 0xF81C9D11, 0xC60CF386, 0xDF6CA6AF, 0x08500274, 0x2F880357, 0x7A50D274, 0x00239A20 },
{ 0x0688CBCC, 0x01B215AB, 0xCF6516CC, 0x46352D96, 0xB7757DF2, 0x112D0F83, 0xC1E5683F, 0x01006355 },
{ 0x3A1D26B0, 0x20923E36, 0x0624E233, 0xB400544E, 0xEC477849, 0xB6A624B5, 0x0C2986BC, 0x032AE724 },
{ 0x41973272, 0x85D62F3D, 0xE61B3007, 0xD5DE203E, 0xE00E9093, 0x499AE945, 0x753BE19F, 0x02A864CF },
{ 0x33DA6243, 0x26442AB8, 0x8C617F58, 0x4C228628, 0xC6217387, 0xEC83370F, 0xD6EA7095, 0x02B7FA37 },
{ 0x358CE998, 0x265CE02F, 0x535C61DF, 0xBB6D7300, 0x6822BF2C, 0xA2D47307, 0x1A44DD6A, 0x0203267E },
{ 0x0A4D606E, 0x2A274BD9, 0x1ACFDCED, 0x13F8E945, 0xE5B9D6F9, 0x6402434F, 0x1DF7D23C, 0x02547664 },
{ 0x9D936487, 0x332CD896, 0xB98C8D51, 0x2D64DDD2, 0x42D61090, 0xBD482CE5, 0x60C15942, 0x025E4558 },
{ 0x0AE81C18, 0x6727B50C, 0x5C62D64B, 0xB5E4F42C, 0x8A77E32A, 0xE59C4572, 0x3A14A434, 0x009468AF },
{ 0x57322E39, 0xD285B3F1, 0xA7E19194, 0x53684E99, 0x49317FBF, 0x8FC81A57, 0x2E342517, 0x017F59F0 },
{ 0xB2C2E035, 0x5B1DEC2D, 0xFE65A753, 0x2BB2D586, 0x1FDBF77D, 0x005ABEAA, 0x4C8F67B3, 0x0230F4A5 },
{ 0x83F82ABC, 0x5F8B29DF, 0xE2FF9CBE, 0xE2FC81FB, 0xC362B730, 0x0DB58435, 0x5D1993EB, 0x00FE0FDC },
{ 0xF93B598C, 0x0C2C73FA, 0x29A59521, 0x210F936B, 0x8B59D1D2, 0xC05F4409, 0xE8E4B00B, 0x02C4950A },
{ 0x9FDDE24B, 0x7455BB58, 0x85EB09B1, 0x3A14AB6E, 0xF677C040, 0xC73976DE, 0xF0E55700, 0x02A98A5E },
{ 0xD6378D19, 0x53E4149B, 0x4A6F53FD, 0xB913983B, 0x93995172, 0x72B8F423, 0x11B4B34A, 0x01A84784 }};

limb_t add_fp_ok[TESTS][8] = {
{ 0xE5D270AC, 0x75D368FD, 0x2B28B6D7, 0x59231EFF, 0x9435D431, 0x014AC543, 0x4B39DDF1, 0x013DF4FC },
{ 0xBD21A057, 0xC4E5FEAB, 0x6490D5AC, 0x51A950EC, 0xCB78D5AA, 0x45EBFD8A, 0x51C70139, 0x02246415 },
{ 0xD3D7F1CC, 0x88C6E82D, 0x0B047A10, 0x5D178A1E, 0x688329E3, 0x530203B1, 0xBB56113B, 0x0103107D },
{ 0x7EC97E1C, 0x80AD86C6, 0x5F8E4686, 0xB62273AD, 0xD97603AF, 0x21013538, 0xF105A3AB, 0x02A9AB85 },
{ 0x708D84AE, 0x3EBC2208, 0x17F93CEF, 0x439CD2C2, 0xA451226D, 0x9885AA9C, 0xB38F7680, 0x005084D5 },
{ 0x6BF4BB97, 0xD5D5FEBA, 0x61E58D41, 0x0B3677C4, 0x5AD74CE1, 0xCDF065BC, 0x50EA7340, 0x037535B7 },
{ 0xDB74EF47, 0x4ED0A434, 0x8CD9B6F0, 0x2038D88D, 0x0E771645, 0x14F68F78, 0x9C5F1853, 0x01DD0D75 },
{ 0x48F344F6, 0x8E6F493A, 0x974357D6, 0x21C73FA8, 0xC268A23C, 0x526B8909, 0x35CC9BC2, 0x03434019 },
{ 0x20F939D7, 0xF9E67623, 0x694BB882, 0xD643D3A6, 0xC5792CCA, 0x42FACB50, 0xB093BAA4, 0x00F39B18 },
{ 0xEF987606, 0xF253553B, 0x8F8E4C18, 0x0C314E75, 0x2E42E197, 0x0A91AD5C, 0x6D88FA2A, 0x02206431 },
{ 0xD438C574, 0x0E225555, 0x6E797333, 0x05CAC3F5, 0xC148F0E8, 0xE6FBB8EB, 0xC687EC12, 0x02EE1F83 },
{ 0xDA34AC02, 0xA88BDA33, 0xB42E25CE, 0x86A30924, 0xE62BAD0C, 0xDA17CE00, 0xD401E058, 0x0177688F },
{ 0x6F736B85, 0xFD540BDE, 0x19D4C356, 0xB5A39056, 0x8EF05D7A, 0xC4D74C29, 0x130389B7, 0x01F697A7 },
{ 0x1E1C634A, 0x25B6A482, 0x70E1734F, 0xD4E8984C, 0xAFE4F6D2, 0xC27E3E49, 0xA43415CB, 0x032FBFFA },
{ 0x44314AFC, 0x5019E058, 0xB90F0867, 0xD43A34C9, 0xCA38980D, 0x4D1DEF27, 0x6993194A, 0x00A0C5C8 },
{ 0x5EA373E7, 0x8A71CD43, 0x883E5C27, 0x6D79F04D, 0x996C15F5, 0x70E2BE0A, 0x04320673, 0x017E2D5A }};

limb_t sub_fp_ok[TESTS][8] = {
{ 0x87B0C825, 0xEF679C58, 0x6B415B44, 0x67EAC3D2, 0xDC3A4245, 0x73693927, 0xC69F9F13, 0x01D69D22 },
{ 0x0F459137, 0xD4ACC488, 0xD876EE9E, 0x92D0038C, 0xBAD8D0C0, 0xE6DBF6DC, 0x5D255C50, 0x01DD2FD4 },
{ 0xC6C65A33, 0x8562BCD7, 0x6C3A4C78, 0x29B12EF0, 0x245E6E88, 0x9D802B1F, 0x7BA23235, 0x027D9E2D },
{ 0x0A8F30BA, 0x3F890A5A, 0x53448220, 0x0029CB11, 0x5673942F, 0x8D6578B7, 0x60E07922, 0x034A85F4 },
{ 0xED5F1FC8, 0x330FC38D, 0x4BC2DCE0, 0x49E89244, 0x39C08258, 0xDF0064FB, 0x51459632, 0x01F663ED },
{ 0x043FF710, 0x894DA94A, 0x49228E91, 0xCBF56B73, 0xF95AA65B, 0x61C23E11, 0xE72C838D, 0x018095A2 },
{ 0x705B1C16, 0x0216E3D6, 0xE620F332, 0x0261F28C, 0x68F7D875, 0x3C25EFDE, 0xABEC4EF6, 0x015214D4 },
{ 0x34588419, 0x3A20B188, 0x61A39DFC, 0x52D96D1E, 0x21BB34D3, 0xF73F48DF, 0x3DF3E8C1, 0x0215A7AC },
{ 0xE5D270C7, 0x938CC4F5, 0xF6329DE0, 0x2D821800, 0x95598CBD, 0xA21AFE70, 0x773EEB0F, 0x032DB91E },
{ 0xD9C83DD6, 0x2403EB23, 0xD6C89F82, 0xA067661C, 0x19531B41, 0x3F592277, 0xF95FB1C0, 0x00F792D2 },
{ 0x25D46901, 0x6916ED73, 0x1EB65009, 0xB7FE26C2, 0x59AC31F2, 0x3443CAB2, 0xAE36935C, 0x036ABFFE },
{ 0x74AEEB97, 0xF25001D8, 0xB762D727, 0x88415E16, 0xD139FE9B, 0x463A9721, 0x7EFA026B, 0x0090D3A0 },
{ 0x6783160C, 0x3E3DB81F, 0x53D589DA, 0x48AE8C5E, 0x32F12FA2, 0x16448A33, 0x9CE7535A, 0x0375CC49 },
{ 0x2BA5B031, 0x0D5DBC8C, 0x1D96490D, 0xEBCD7176, 0xC3F793B7, 0xAE97FCAB, 0x1681A72C, 0x0121EA40 },
{ 0x04758664, 0x676E69A7, 0xAD38F504, 0x1218DDEC, 0x32D598A0, 0x985B8E54, 0x0FF64E39, 0x024459C1 },
{ 0xB23459B4, 0xE2A9A40B, 0xF35FB42C, 0x5456BFD6, 0x9CFFB399, 0xF8491C38, 0x24DF9156, 0x01A8F2AD }};

limb_t mul_fp_ok[TESTS][8] = {
{ 0x83994DE4, 0x981E3B0B, 0x1AD1F6C0, 0x83E7130D, 0xA3F2301E, 0x378555F9, 0x936C2A1B, 0x0217C10D },
{ 0x563B0875, 0x06FF6CC3, 0x22A631C2, 0xDA975D51, 0x0B14BD6A, 0x3B42FED8, 0xD10A7B90, 0x0278D7E3 },
{ 0xC62D3792, 0xC8F05F3E, 0x9B138627, 0x67312D98, 0x860B2BDD, 0xEAD47DB6, 0x21BB386B, 0x0237B979 },
{ 0x472F0378, 0xB083464E, 0xAF50867E, 0x65B0D213, 0x99737AC1, 0xE185FCD0, 0x9909D182, 0x0336384B },
{ 0x4409B913, 0xC75BC4F3, 0xCF91E12E, 0x0388EB88, 0x00DE5444, 0x5E20F923, 0x46E5B6C3, 0x005D70E9 },
{ 0xA9EFA0E0, 0x34C6E10B, 0x5D7E7123, 0x68F76B17, 0x7F94997D, 0xD7CABAE3, 0x517B3385, 0x01A84EFF },
{ 0xBF763FFE, 0x252866F0, 0xF0F38404, 0x05B53E80, 0xB5B1723B, 0x9D130F8E, 0x9F80DB35, 0x026C689F },
{ 0xBD19FCCF, 0x28CCAFB6, 0x9A05EC0F, 0x457A2C84, 0xF855E99F, 0xFD46A841, 0xD2183D4F, 0x014B94B2 },
{ 0x937B968D, 0x69355602, 0x2B21AB11, 0xCBFB1323, 0xB166E01F, 0x119E1C56, 0x6DEEF969, 0x02EC6D78 },
{ 0x5F0FBAA9, 0x16D70514, 0x70D0D94F, 0x3F1AB89E, 0x9BB88C8D, 0x82D66664, 0x20CB834E, 0x00CB99BC },
{ 0x329D9626, 0x1E01BF3F, 0x91045EB0, 0xD9A63F8A, 0x0CAC4721, 0xEDC1802B, 0x123D6A4A, 0x0350C046 },
{ 0x95A9B38C, 0xD886F3FC, 0x65BB3152, 0xF3822B7C, 0xC2E98E3D, 0x2C23C3AF, 0xCDD49FF8, 0x01D63534 },
{ 0x37187F64, 0xC4093080, 0xEFDAD2D2, 0x73EEDBD4, 0x5D4DF99C, 0x767EA319, 0x87A7995A, 0x0053D3C2 },
{ 0x0DBBD905, 0xE38F4FDA, 0xCC43C2C7, 0xCB868A83, 0x0A7BC02C, 0x917846F9, 0x9EDF1BB5, 0x0284F551 },
{ 0xB1E5D52D, 0x72F34E7B, 0xEBCEA5F3, 0xF833C997, 0x1F6D5FBF, 0xBBCEA045, 0x444EAADD, 0x010ADFF7 },
{ 0x7A5E3546, 0xD620A806, 0x469109E0, 0x58E2825A, 0x0C298FD4, 0x461ADFC8, 0xFE05FFAD, 0x02FA161D }};

limb_t sqr_fp_ok[TESTS][8] = {
{ 0x9BA02899, 0x2E3303FD, 0xB791466F, 0xF8BC4F33, 0x031C5B7D, 0x42745649, 0xF0D227FA, 0x01B08616 },
{ 0xBCC849B2, 0x189181E3, 0x3A6D2F65, 0x804B4502, 0x6CBE75B7, 0xD39D3D3D, 0x4FC36978, 0x01105CC5 },
{ 0x4A570436, 0x7E0A11BE, 0x929E4811, 0x8FCC0144, 0xB32F0F87, 0xE7EC93F5, 0x133C35EB, 0x00F88265 },
{ 0x7CB177DE, 0xB86D176D, 0x38CE181A, 0xBE97EBC1, 0xF1DFA6D1, 0x471B706B, 0x9F0C6314, 0x0200B6BD },
{ 0x27C8E8B8, 0x9B55898D, 0xDB507537, 0x4FEFDCBD, 0xD1FE6E44, 0x5B757066, 0xDEFA3EA6, 0x02218979 },
{ 0xC2F52E06, 0x7EF1B56B, 0x6438F5F9, 0x9ABEFB26, 0x107BBFFC, 0x3BFE6636, 0x03DFEBF9, 0x0114EC64 },
{ 0xFC650529, 0x8AF1A6DB, 0x1FEA3814, 0x4FDB4495, 0x9C695382, 0x1D737F3F, 0x6592E05F, 0x00039FC7 },
{ 0x2BB5C0A4, 0xA347CCF9, 0x472812E4, 0x30CB6BAC, 0x6691A6A1, 0x1049E540, 0x111E005E, 0x01902D36 },
{ 0x4F966609, 0xA78D4DEB, 0xAF4D81B6, 0x3D3CF77B, 0x1806A1A3, 0xF174B688, 0x53E03E8C, 0x03573BEF },
{ 0xD7C34D22, 0x7ED7707C, 0xA9AE3EA1, 0x31E5BA16, 0xE0C43AAF, 0x535712BE, 0x60066C14, 0x003F3C53 },
{ 0xD8D277D6, 0x368C3764, 0x23FCBA09, 0xDBB9FE2A, 0x229D5CE1, 0x53D7D921, 0x90D7345E, 0x0280A269 },
{ 0x41E251CB, 0x5690C656, 0x15B770D9, 0xE093A558, 0x2F26BD30, 0xACFA1B8A, 0xB67746BC, 0x020449DE },
{ 0xE8AFF373, 0xBD3114D1, 0x920B6426, 0x0F221163, 0x2EE05D03, 0x66FAAFF8, 0xC9690A78, 0x00E11227 },
{ 0x6D03BF77, 0xB04E3BA1, 0x75F61E8A, 0x70869E2A, 0x6F2D880A, 0xBB9D39E2, 0x2FA207E2, 0x020DDACA },
{ 0x4ECC392F, 0x1EAF4886, 0x959DE459, 0x493641B3, 0xAD5ABDE3, 0x2A1801C1, 0x1C485589, 0x024E0769 },
{ 0x0DF0F89E, 0xC3C00271, 0x8C3B5A37, 0x72D096DA, 0xD8F4323D, 0xCA1FF141, 0x01DD458C, 0x025681B7 }};

limb_t mul_ok[TESTS][16] = {
{ 0x88B20F38, 0xFAA24B7C, 0xD9ECBC82, 0x19F7533B, 0x2009F0BD, 0x3B523793, 0x4D6501B2, 0x730F8670, 0x250ECEF0, 0xCCB9F5BF, 0xFB4C1E9D, 0x9382C5C6, 0xBE21385A, 0x280E6481, 0x1D796E20, 0x0004BBD0 },
{ 0x493560F0, 0x825871C2, 0x081FDCE1, 0x32391074, 0x8B91BB3D, 0xC05D0515, 0x27F89BE5, 0xB224B759, 0x9446FBC4, 0x368272FC, 0x57A59DB1, 0x2AA5E386, 0x3297EB49, 0xC571B035, 0x5704FF83, 0x00004750 },
{ 0x8E344800, 0x1BCEC7F9, 0x7690621D, 0x94229207, 0xAE832A47, 0xBC4FF7D0, 0xD21D6280, 0x79F6B34F, 0x6B9C598C, 0xEC6DE755, 0x193B0425, 0x5501FDA8, 0x23997ED2, 0x7ED4977D, 0x31D56B56, 0x000002AE },
{ 0xF094FB90, 0x7BFA7B46, 0x4B503FB6, 0x079A903D, 0x40470763, 0xF7B533B6, 0xBE86D001, 0x662683C2, 0x3E36D92E, 0x5CCBAC05, 0x9F12DC4F, 0xE8A2CA51, 0xFF18016F, 0x94859939, 0x5E25F060, 0x00096E02 },
{ 0x818D2446, 0xDAB378E1, 0xF80525DC, 0xDB30D771, 0x26C77F16, 0x0811C4AA, 0x2EE9F8DB, 0xBB89ACE9, 0x580A759A, 0x371111A7, 0x304FF7EE, 0x65A7D0B1, 0xB681A7C3, 0x30AEF4A4, 0xE8A9151C, 0x0003069F },
{ 0x929F88FC, 0x994C58AA, 0xBC9398B8, 0x8C233645, 0xE1C3DB95, 0xFCBD14E7, 0x45F3FC30, 0xDDA2439F, 0xA50FF76B, 0x5B90C3B3, 0xADAC12BF, 0x385D3B10, 0xBA85B1C8, 0xA1E132EB, 0x7C755896, 0x00020275 },
{ 0xD016BD50, 0x19AE965C, 0x2CD315E6, 0xB3E47A95, 0xE85597F0, 0x9A6663CC, 0x02B16F4B, 0xF0D4C465, 0x1D8CA51F, 0x4E34745A, 0xAA15FD92, 0x3CC5D7AB, 0xE6983CD0, 0x4168270A, 0xA29DBEA1, 0x0006B4F6 },
{ 0x2DE33270, 0xEDF03962, 0xAE1EC8E5, 0x56990C93, 0xF4D08259, 0xF732297E, 0xCF85F384, 0xEE176260, 0xB327F202, 0x1B85A274, 0xA41F59D9, 0xC4FDFA3C, 0xD56CF6FA, 0xCB09B753, 0x07F7B320, 0x00022C5C },
{ 0x016358A9, 0x41EB8402, 0x3711EA46, 0xF87ECB26, 0x0D5249F1, 0x621D1C33, 0xF59ED3C7, 0x21918B7F, 0x82AACE0F, 0xE85EFB11, 0x3601311F, 0x5CE0D4A0, 0xF726973D, 0xC6ADB438, 0xE1A3D9BD, 0x0004E401 },
{ 0x860E7650, 0xB90DE1FD, 0xC13AD0FE, 0x6D345482, 0xE74CC8A9, 0x75232A20, 0xEF1BAF69, 0x63CBC7BE, 0x96235D82, 0x7E252E77, 0x50790F4C, 0xB74C7E25, 0x6C995573, 0x45F1C125, 0x547D6913, 0x0000E58F },
{ 0x9C2A4623, 0x5D974610, 0xAFE9F2FE, 0x921A497C, 0x1765F68A, 0x91B3CE79, 0x153EB3A0, 0x32D99962, 0x3698D1B2, 0x34BB611D, 0xEBCC1621, 0x4610B668, 0xDD2CF2AA, 0x6C697646, 0x729CA1E0, 0x0002253A },
{ 0x0579B13C, 0x511B9096, 0x9640C601, 0xC66BA951, 0x0FE7B586, 0x09EF306E, 0xC783D91E, 0x77EEA393, 0xFC9C9F78, 0x8B6CD3B5, 0xCE2CB939, 0x1D842A17, 0x70FF6224, 0xC76E3C98, 0x9348EA64, 0x00060A88 },
{ 0xC4DC8D9C, 0xD7EE9B7B, 0x819AE321, 0x8DBC105F, 0x7BD43E37, 0x57671242, 0x752F1DD1, 0x02E7B0F7, 0xB7735E6C, 0xF04FFD50, 0x988213CA, 0x8937562A, 0x1CD73EEF, 0x6CA10CF9, 0x21047328, 0x0000F6A6 },
{ 0x743E61E8, 0x5441C59D, 0xF34BA84F, 0x31D51549, 0x84FA41FC, 0x9E564EFA, 0xBDAD1437, 0x40319662, 0x8A1FFAEE, 0xFB3955A3, 0x2AF8062A, 0x84445A37, 0xB066188E, 0x200B907D, 0x2390BB9D, 0x000128A1 },
{ 0x76CB0B90, 0x2F75BC7D, 0xA09A1854, 0xF9CBCC2F, 0x508E70F7, 0x36CC76AB, 0x146E6111, 0x235B7441, 0x547042B5, 0x6CBA4BC6, 0x873B46A7, 0x3D5FF176, 0xC33D9823, 0x8400C7B9, 0xBD47B202, 0x0003DA88 },
{ 0xB4B37305, 0x278492BC, 0x1F6A2C99, 0xBEE0D496, 0xF552FADF, 0xCB64D690, 0x232C2AAA, 0xA17112F5, 0x5A44B103, 0x1F399BBE, 0xE25DECEE, 0x126FF2B6, 0xE3E6525E, 0xE0B768FB, 0x9EC2C961, 0x00057F75 }};
