/*
 Navicat Premium Data Transfer

 Source Server         : MySQLServer
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : online_cinema

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 26/11/2023 14:29:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `a_admin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'admin',
  `a_password` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456');

-- ----------------------------
-- Table structure for commit
-- ----------------------------
DROP TABLE IF EXISTS `commit`;
CREATE TABLE `commit`  (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论',
  `u_id` int NOT NULL COMMENT '用户id',
  `m_id` int NOT NULL COMMENT '电影id',
  `m_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`c_id`) USING BTREE,
  INDEX `u_id`(`u_id` ASC) USING BTREE,
  INDEX `m_id`(`m_id` ASC) USING BTREE,
  CONSTRAINT `commit_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commit_ibfk_2` FOREIGN KEY (`m_id`) REFERENCES `movie` (`m_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of commit
-- ----------------------------
INSERT INTO `commit` VALUES (1, '吓银~~~', 1, 30, '2023-11-16 17:02:13');
INSERT INTO `commit` VALUES (2, '海星，，，一般般', 1, 19, '2023-11-16 17:04:30');
INSERT INTO `commit` VALUES (3, '就这？？？（吓死宝宝啦~）', 1, 3, '2023-11-16 17:04:58');
INSERT INTO `commit` VALUES (9, '楼下什么小马云？？？', 3, 30, '2023-11-16 21:26:55');
INSERT INTO `commit` VALUES (10, '你男的女的？不会是南通叭？', 3, 19, '2023-11-16 21:28:13');
INSERT INTO `commit` VALUES (11, '这个一般吧，吓不死人，，鹅鹅鹅鹅鹅鹅...', 3, 3, '2023-11-16 21:28:57');
INSERT INTO `commit` VALUES (12, '666', 3, 19, '2023-11-16 22:08:22');
INSERT INTO `commit` VALUES (13, '下午好！', 1, 3, '2023-11-17 15:18:27');
INSERT INTO `commit` VALUES (14, '动物园？', 1, 32, '2023-11-17 19:44:14');
INSERT INTO `commit` VALUES (15, '匿名发表评论？？？', 3, 14, '2023-11-17 20:59:39');
INSERT INTO `commit` VALUES (16, '这就是传说中的小鬼当家吗？针不戳', 3, 5, '2023-11-17 21:03:48');
INSERT INTO `commit` VALUES (18, '465', 3, 37, '2023-11-18 19:32:57');
INSERT INTO `commit` VALUES (21, 'cors', 3, 18, '2023-11-19 11:13:13');
INSERT INTO `commit` VALUES (22, 'cors！！！！！！！！！！！！！', 1, 7, '2023-11-19 12:32:20');
INSERT INTO `commit` VALUES (24, '哈哈哈哈.........', 3, 6, '2023-11-19 14:49:35');
INSERT INTO `commit` VALUES (25, '1232', 3, 22, '2023-11-19 17:31:21');
INSERT INTO `commit` VALUES (27, '好好好~！！！！！！！！！！！！！！', 3, 4, '2023-11-20 23:01:23');

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie`  (
  `m_id` int NOT NULL AUTO_INCREMENT,
  `m_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电影名称',
  `m_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电影类型',
  `m_director` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '导演',
  `m_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `m_duration` int NULL DEFAULT 0 COMMENT '时长',
  `m_poster` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'http://localhost:9000/images/default.png' COMMENT '海报',
  `m_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'http://localhost:9000/movie/default.mp4' COMMENT '链接',
  `m_count` int NULL DEFAULT 0 COMMENT '点击量',
  PRIMARY KEY (`m_id`) USING BTREE,
  INDEX `1`(`m_type` ASC) USING BTREE,
  CONSTRAINT `1` FOREIGN KEY (`m_type`) REFERENCES `type` (`t_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES (3, '死寂1', '恐怖', '唐尼·沃尔伯格、安贝·瓦莱塔', '恐怖片，谨慎观看！', 92, 'http://localhost:9000/images/43fe6e34-2efb-49a5-87e0-d00c0e064f47死寂.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (4, '鬼影1', '恐怖', '阿南达·爱华灵咸', '该片讲述了年轻的自由摄影师Thun（AnandaEveringham）', 97, 'http://localhost:9000/images/de4c69a1-09ef-41d4-a6e2-4af32dd82c12鬼影.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (5, '小鬼当家1', '喜剧', '麦考利·卡尔金', '一年一度的圣诞节又到了。全家忙着外出欢度圣诞假期，不料忙中出错，将家里最小的成员——8岁的凯文留在了家里。', 103, 'http://localhost:9000/images/e7f10da8-54a9-43d5-a7f5-2b4383aa4bae小鬼当家.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (6, '国产凌凌漆', '喜剧', '周星驰、袁咏仪', '凌凌漆（周星驰饰）是国家后备特工，因长期被上级弃用，而沦为卖肉摊主。', 84, 'http://localhost:9000/images/f99bd5fa-1d7c-46b5-9d4f-019988643744国产凌凌漆.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (7, '上帝也疯狂2', '喜剧', '历苏、Lena Farugia', '黑人部落的基有两个孩子：姐姐8岁，叫丝莎，弟弟5岁，叫沙理。一天，姐弟二人误上了一辆白人象牙偷猎者的卡车，幸好基及时发现并奋力追赶。', 98, 'http://localhost:9000/images/f3123eee-3a47-406e-b78a-d43dfc75ba13上帝也疯狂2.jpg', 'http://localhost:9000/movie/5544f27c-731e-4de4-9c07-3de28ebec4f4Spring Boot_百度百科.mp4', 0);
INSERT INTO `movie` VALUES (8, '唐伯虎点秋香', '喜剧', '周星驰、巩俐', '江南才子唐伯虎（周星驰饰）天资聪慧，仪表堂堂，琴棋精通，诗画双绝，位居江南四大才子之首。', 102, 'http://localhost:9000/images/368d48fb-0b71-470b-bfb1-1fbecc03b5a0唐伯虎点秋香.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (9, '热血警探', '喜剧', '埃德加·赖特执导，西蒙·佩吉', '安吉尔和丹尼·巴特曼结成了搭档，巴特曼善良、热心而天真，他是当地警察局督察员的儿子，还是一个动作片影迷。', 121, 'http://localhost:9000/images/7ddb371d-e963-4029-a657-f14630676f2d热血警探.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (10, '午夜凶铃', '恐怖', '松岛菜菜子、真田广之', '午夜凶铃于1998年上映，由中田秀夫执导。包括同名的系列电影及图书等。', 98, 'http://localhost:9000/images/47f655aa-3dee-4764-a86d-f53886db8526午夜凶铃.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (11, '特种部队：全面反击', '动作', 'D·J·科特罗纳、阿德琳妮·帕里奇', '地球上出现了一个极其神秘的恐怖组织，它的名字叫“眼镜蛇”，而让“眼镜蛇”闻名全球的原因', 110, 'http://localhost:9000/images/053939ab-8d62-4b53-adbd-b1984287b421特种部队：全面反击.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (12, '惊天危机', '动作', '查宁·塔图姆、杰米·福克斯', '约翰退役后被众议院议长拉弗森选为个人保镖，但他并不太满意这份工作，他梦想成为一名特勤局特工直接保护总统索耶。', 131, 'http://localhost:9000/images/b4aabdfb-3605-4477-8dda-0f67432ca531惊天危机.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (13, '犯罪都市', '动作', '马东锡、尹启相', '2004年，来自哈尔滨的黑帮组织大举入侵首尔，引发社会恐慌', 122, 'http://localhost:9000/images/aaa24689-1973-40bb-a84a-7781d53563b7犯罪都市.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (14, '007：无暇赴死', '动作', '丹尼尔·克雷格、拉尔夫·费因斯', '世界局势波诡云谲，在老朋友费利克斯·莱特前来寻求帮助的情况下，詹姆斯·邦德（丹尼尔·克雷格饰）再度出山，面临有史以来空前的危机。', 163, 'http://localhost:9000/images/3de1eb8b-395b-4327-a05d-75bb1e444544007：无暇赴死.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (15, '红色通缉令', '动作', '道恩·强森、瑞安·雷诺兹、盖尔·加朵', '世界头号艺术品大盗、讽刺伪造大师诺兰·布斯（瑞安·雷诺兹饰）和他的克星、世界头号通缉的艺术品窃贼被称为“主教”', 117, 'http://localhost:9000/images/34f820c4-5583-4728-a0bd-44ae2e238a82红色通缉令.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (16, '地狱尖兵', '战争', '阿列克谢·克拉夫琴科', '在一名呼啸山庄战士的带领下，冲锋队面临着一项艰巨的任务:控制市中心的高楼大厦。坦克和装甲运兵车本应让任务变得轻松', 109, 'http://localhost:9000/images/ecd676ee-678c-495b-aec0-c0e2ca108a02地狱尖兵.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (17, '黑鹰坠落', '战争', '乔什·哈奈特', '黑鹰坠落（电影称为“黑鹰坠落”，一般将美国在1993年的索马里军事行动称为“黑鹰事件”）是1993年美军在索马里执行军事行动时出现意外，由于情报有误，导致两架黑鹰直升机被RPG火箭筒击落。', 125, 'http://localhost:9000/images/bcd16c98-c475-4acd-bbd3-bdcf837787bd黑鹰坠落.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (18, '猎杀u-571', '战争', '马修·麦康纳、比尔·派克斯顿', '1942年4月，第二次世界大战期间，大西洋上，史上规模最大的海军战役正在进行中.', 116, 'http://localhost:9000/images/e4703c8d-b38f-4c79-9eb8-ce512a0e31bd猎杀u-571.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (19, '寂静岭', '恐怖', '拉妲·米契尔、祖蒂·弗兰', '本片为一个恐怖片，慎看！', 126, 'http://localhost:9000/images/71847ca2-6990-47bb-8714-82d0bb2036df寂静岭.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (20, '兵临城下之决战要塞', '战争', '安德烈·马斯连基、叶甫盖尼·塞格诺夫', '1941年6月22日，布格河东岸的公园里，军乐队演奏着欢快的歌曲，男女老少跳舞嬉戏，一切都是那么恬静、祥和。', 133, 'http://localhost:9000/images/d7ed6e63-3c27-46c7-bf36-3a3e9da63703兵临城下之决战要塞.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (21, '火星救援', '科幻', '马特·达蒙、杰西卡·查斯坦', '人类实现了首次在火星上登陆，美国宇航员马克·沃特尼（马特·达蒙饰），他与其他五位宇航员遭遇巨型风暴，外太空之旅只能提前结束。', 130, 'http://localhost:9000/images/bd4c7157-4217-408d-9e3d-c8c6c791a26a火星救援.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (22, '星际穿越', '科幻', '马修·麦康纳、安妮·海瑟薇', '地球农作物因气候转变及枯萎病而经常失收，曾是美国国家航空航天局的工程师和航天飞机驾驶员的库珀（马修·麦康纳饰）被迫成为农民以协助解决粮食危机。', 169, 'http://localhost:9000/images/76e4416f-6d88-4489-8d49-1dfc7c92c9e2星际穿越.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (23, '头号玩家', '科幻', '泰尔·谢里丹、奥利维亚·库克', '2045年，处于混乱和崩溃边缘的现实世界令人失望，人们将救赎的希望寄托于“绿洲”，一个由鬼才詹姆斯·哈利迪（马克·里朗斯饰）一手打造的虚拟游戏宇宙。', 145, 'http://localhost:9000/images/64442774-0afb-4f2e-adc5-a8021e4ee822头号玩家.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (24, '月球陨落', '科幻', '帕特里克·威尔森、哈莉·贝瑞', '随着人类为了拯救地球而重返月球，被掩盖长达50年的真相渐渐浮出水面：月球不是自然形成的天体，而是一个惊人的巨型“人造物”。', 130, 'http://localhost:9000/images/5f2192ca-a021-43c9-97f7-3323023a3e89月球陨落.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (25, '流浪地球', '科幻', '吴京、吴孟达', '近年来，科学家们发现太阳急速衰老膨胀，短时间内包括地球在内的整个太阳系都将被太阳所吞没。', 125, 'http://localhost:9000/images/8c4d8e8e-e56a-4ad0-b0ed-cef9c9d32d01流浪地球.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (26, '古墓丽影', '冒险', '安吉丽娜·朱莉、乔恩·沃伊特', '当三颗行星在天上排成一列时，劳拉在她父亲二十年前挖掘古墓带回的箱子里找到一个神秘的时钟。', 100, 'http://localhost:9000/images/20e4c657-4946-42e1-9b94-f4cc08c74762古墓丽影.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (27, '侏罗纪世界', '冒险', '克里斯·帕拉特、布莱丝·达拉斯·霍华德', '侏罗纪公园建立22年后，纳布拉尔岛已经发展成为一个庞大的主题公园和度假胜地——侏罗纪世界。', 124, 'http://localhost:9000/images/81f7e7e9-5e20-48c1-b922-33f22265f4a6侏罗纪世界.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (28, '加勒比海盗', '冒险', '约翰尼·德普、奥兰多·布鲁姆', '杰克·斯帕罗（约翰尼·德普饰）是个加勒比沿海小镇子上不务正业的小痞子，别看他眼下是混得这么惨。', 143, 'http://localhost:9000/images/0d801fa6-e69a-467e-81e6-7c7e2f6a080e加勒比海盗.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (29, '奇幻森林', '冒险', '乔恩·费儒执导，尼尔·塞西', '男孩毛克利（尼尔·塞西饰）由狼群养大。', 120, 'http://localhost:9000/images/346a5f35-8cb5-4959-bffd-349597a246e0奇幻森林.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (30, '咒怨', '恐怖', '奥菜惠、酒井法子、伊东美子', '本片为一个非常恐怖的电影，请在家长的陪同下观看！', 92, 'http://localhost:9000/images/7f138fdc-e9d1-4be5-967f-d9c5e1491564咒怨.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (31, '千与千寻', '动画123', '柊瑠美、入野自由、中村彰男', '有点娇气任性的10岁少女千寻（柊瑠美 配）跟随父母搬往新家，途中误入一座神庙', 125, 'http://localhost:9000/images/18b60215-6159-4ca2-9914-e5af038d81fa千与千寻.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (32, '疯狂动物城', '动画123', '金妮弗·古德温、杰森·贝特曼', '一个现代化的动物都市，每种动物在这里都有自己的居所，有沙漠气候的撒哈拉广场、常年严寒的冰川镇等等。', 109, 'http://localhost:9000/images/c975f650-a7ce-43ac-8a40-a6d52b43faa6疯狂动物城.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (33, '驯龙高手', '动画123', '杰伊·巴鲁切尔、亚美莉卡·费雷拉', '故事的主人公是一个叫希卡普的维京少年，他住在博克岛，对抗巨龙是家常便饭的事。', 98, 'http://localhost:9000/images/ad04399b-966d-4f4e-b371-1764c8a6f630驯龙高手.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (34, '超能陆战队', '动画123', '瑞恩·波特、斯科特·埃德希特', '在一个融合东西方文化（旧金山+东京）的虚构大都市旧京山（San Fransokyo）中。', 102, 'http://localhost:9000/images/8a3e65a5-99b1-4d5c-9fcb-6c84ce30350f超能陆战队.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (35, '你的名字', '动画123', '神木隆之介、上白石萌音', '故事背景发生在适逢千年一遇彗星到访的日本，生活在日本小镇的女高中生宫水三叶对于担任镇长的父亲所举行的选举运动', 106, 'http://localhost:9000/images/73c59faf-ecc3-4445-b444-a1172de67678你的名字.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (36, '末代皇帝', '历史', '贝纳尔多·贝托鲁奇执导，尊龙', '1950年的冬天，清王朝废帝溥仪（尊龙饰），作为战犯从苏联被押回中国。', 163, 'http://localhost:9000/images/b5e9ba78-a646-4606-ab49-eac60b93a01d末代皇帝.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (37, '300勇士：帝国崛起', '历史', '苏利文·斯坦普莱顿、罗德里格·桑托罗', '在著名的马拉松战役中，希腊英雄地米斯托克利（苏利文·斯坦普莱顿饰）射杀波斯国王大流士王。', 102, 'http://localhost:9000/images/65753c97-ef03-4c96-a1ae-a143bd64768e300勇士：帝国崛起.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (38, '亚瑟王', '历史', '克里夫·欧文 、凯拉·奈特丽', '亚瑟（克里夫·欧文 饰）从小就在战乱中和家人失散，被人收养并成为一个被人看不起的杂役.', 130, 'http://localhost:9000/images/66ee2b56-edfd-4f8a-8e1d-4a98d7798b87亚瑟王.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (39, '荆轲刺秦王', '历史', '巩俐、张丰毅、李雪健', '公元前3世纪的中国，为群雄割踞的战国时代，雄心壮志的秦始皇嬴政统一天下的大业。', 162, 'http://localhost:9000/images/beaf7d91-7449-4b6f-98b8-74422a95629e荆轲刺秦王.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (40, '建军大业', '历史', '刘烨、朱亚文、黄志忠、王景春', '1927年，北伐战争刚取得重大成果之际，国民党反动派为夺权叛变革命。', 120, 'http://localhost:9000/images/e3b54674-55c3-4edc-8aaf-f6208bb5f520建军大业.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (101, '1235456', '喜剧', '1234', '.。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。', 152, 'http://localhost:9000/images/5ccc227b-bb0a-4801-880c-c6ea7b05138a482314363436B1F26D0BA13A8E68B38EE27DB92F0 - 副本.jpg', 'http://localhost:9000/movie/default.mp4', 0);
INSERT INTO `movie` VALUES (102, '机械战警X', '动作', '彼得·威勒', '666666666', 153, 'http://localhost:9000/images/default.png', 'http://localhost:9000/movie/default.mp4', 0);

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `t_id` int NOT NULL AUTO_INCREMENT,
  `t_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电影类型',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`t_id`) USING BTREE,
  UNIQUE INDEX `t_type`(`t_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, '喜剧', 0);
INSERT INTO `type` VALUES (2, '恐怖', 0);
INSERT INTO `type` VALUES (3, '动作', 0);
INSERT INTO `type` VALUES (4, '战争', 0);
INSERT INTO `type` VALUES (5, '科幻', 0);
INSERT INTO `type` VALUES (6, '冒险', 0);
INSERT INTO `type` VALUES (7, '动画123', 0);
INSERT INTO `type` VALUES (8, '历史', 0);
INSERT INTO `type` VALUES (9, '惊悚', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `u_id` int NOT NULL AUTO_INCREMENT,
  `u_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `u_password` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `u_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号码',
  `u_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `u_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'http://localhost:9000/images/default.png' COMMENT '头像地址',
  PRIMARY KEY (`u_id`) USING BTREE,
  UNIQUE INDEX `u_account`(`u_account` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三5', '123456', '12345678910', '桂林信息科技学院', 'http://localhost:9000/images/dd3d830e-8147-4b71-9614-fdfe0dcb40d1482314363436B1F26D0BA13A8E68B38EE27DB92F0 - 副本.jpg');
INSERT INTO `user` VALUES (3, '张三3', '123456', '11111111111', '桂林理工大学000', 'http://localhost:9000/images/bbc5d872-4a72-45cc-b6e4-b23dbd1eb427QQ图片20201203230647.jpg');
INSERT INTO `user` VALUES (6, '张三2', '123456', '18377767444', '桂林旅游学院', 'http://localhost:9000/images/58e79f19-114b-4a21-90c8-71a055197c012377643241A79989C65E584C0CB7800E07383B1605.jpg');
INSERT INTO `user` VALUES (8, '张三疯', '123456', '11111111111', '桂林电子科技大学', 'http://localhost:9000/images/default.png');

SET FOREIGN_KEY_CHECKS = 1;
