模组 《神机密卷》

可穿戴物品。手部位置。

具备等级功能：
    · 【完成】基础等级0级。满级60级。
    · 【完成】使用【彩虹宝石】升级。每个宝石升一级。
    · 未满级前，所有模式外观为【蓝色】。满级后整体外观为【红色】
    · 【完成】移速加成：
        · 初始10% 。击杀【大海象】和【小海象】各一只后开启升级。
        · 使用【手杖】进行移速升级。一根【手杖】增加5%移速。最多增加到 80% 移速（14个【手杖】）。
        · 击杀88个【大海象】和88个【小海象】则继续增加8%移速。


模式：
    · 【完成】远程攻击模式（快捷键切换）：
            · 基础攻击伤害30点。每级增加伤害2点，最高150点伤害。
            · 攻击距离默认10。击杀蜘蛛女王后，开启距离升级功能。使用【蜘蛛丝】升级。每个【蜘蛛丝】提供 0.025 距离加成 。最远可升级成攻击距离20（400个【蜘蛛丝】）。

    · 【完成】近战攻击模式（快捷键切换）：
            · 基础攻击伤害 45点。每级增加2点。最高165点伤害。
            · 初始攻击距离为1。使用【金块】升级。每个【金块】提供0.01加成，最远攻击距离为2。    最大100个

    · 【完成】懒人法杖模式（橙色法杖、快捷键切换）：
            · 喂食【懒人法杖】解锁，初始消耗20san，冷却10秒。
            · 使用【噩梦燃料】升级，每个【噩梦燃料】减少0.2的San值消耗。100个后无消耗。
            · 使用【橙宝石】减少冷却，一个减少一秒，最高10个无冷却。
    
     · 【完成】地图跳跃模式（紫色法杖、快捷键切换）：
            · 喂食【传送法杖】解锁
            · 全地图（可见范围陆地）内右键直接跳跃。消耗50 San。冷却 30秒。 San 不足的时候不可用。
            · 使用【紫色宝石】减少冷却时间。一个减少1秒。最低10秒冷却。20个

    · 【完成】池钓鱼竿模式（快捷键切换）：
            · 钓【淡水鱼】或者【鳗鱼】升级。100条后满级。
            · 满级后，钓上的任何东西，有100%概率变成数量X2。

    · 【完成】捕虫网模式（快捷键切换）：
            · 喂食【捕虫网】解锁。
            · 喂食【萤火虫】升级。100个后满级。满级有10%概率（避免放生重捉刷数量）捕捉的目标时候，得到2个。

    · 【完成】组合工具模式（快捷键切换）：
            · 斧头形态：
                · 喂食任意斧头解锁。初始100% 效率。
                · 喂食【金斧头】 提供 10% 加成。【玻璃斧头】提供100%加成。【斧镐】提供150%加成。
                · 喂食加成最高到1000%
            · 矿镐形态：
                · 喂食任意镐子解锁。初始100%效率。
                · 喂食【金镐子】提供 10%加成。【斧镐】提供150%加成。【亮茄镐子】提供200%加成。
                · 喂食加成最高到1000%
            · 铲子形态：
                · 喂食任意铲子解锁。无法升级。
            · 锤子形态：
                · 喂食【锤子】解锁。无法升级。

    · 三叉戟模式（快捷键切换）：
        · 喂食【三叉戟】解锁。无法升级。

    · 剃毛法杖模式（快捷键切换）：
        · 喂食【剃刀】解锁。无法升级。
        · 对目标施法会剃毛。

   · 护目镜模式（快捷键开/关）：（注： 如果不用快捷键开关，会一只有 屏幕一圈 遮挡。）
        · 喂食【沙漠护目镜】或【星象护目镜】解锁。      weapon_inst:AddTag("goggles")

    · 独奏乐器模式（快捷键切换）：
        · 击杀【果蝇王】解锁。

    · 灯光开启/关闭 （快捷键）：
        · 击杀【天体英雄】解锁。
    
    · 水上行走模式
        · 击杀3只邪天翁后解锁【水上行走】轮盘开关

    · 给予冰魔杖解锁【冰冻攻击】
        · 寒冰法杖解锁【冰冻攻击】，攻击有概率使敌人冰冻（可被二连击触发）
        · 初始几率5%，蓝宝石升级，每颗增加1%的几率，最高20%

    · 【秒杀】
        · 红宝石法杖解锁【秒杀】，攻击有几率秒杀任何敌人（不可被二连击触发）
        · 初始概率1%，每给予一颗红宝石增加0.1%的概率，最高2%


其他击杀解锁：

    · 击杀【熊大】：
        · 击杀 5 只解锁 武器不掉落。   【程序笔记】player:HasTag("stronggrip") 则不会被打掉武器。

    · 击杀【巨鹿】：
        · 击杀1只解锁玩家体温过低保护。初始为 0℃ 保护。体温不会低于这个数值。
        · 解锁后，每击杀1只，体温保护就提高 1℃。 最多20℃保护。体温不会低于20℃

    · 击杀【龙蝇】：
        · 击杀1只解锁玩家体温过高保护，初始为 50℃ 保护。体温不会高于这个数值。
        · 解锁后，每击杀1只，体温保护就提高1℃。最多 30℃ 保护。体温不会高于30℃。
    
    · 击杀【鹿鸭】：
        · 击杀1只解锁防雨功能。默认 TUNING.WATERPROOFNESS_SMALL (0.2)       组件: item.components.waterproofer  
        · 每击杀1只鹿鸭，提供 0.2 加成，最高到 1 。

    · 击杀【树精】：
        · 击杀 10 只后解锁 伍迪砍树效率。  【程序笔记】player:AddTag("woodcutter")

    · 击杀【蜂后】：
        · 击杀1只后解锁【蜂毒】功能。攻击目标会有几率给目标上debuff ： 每秒造成 10 点伤害，持续 10秒。  debuff可叠加。
        · 初始上毒概率为 10% 。 每击杀一只【蜂后】，增加 5%概率。上限30（不可被二连击触发）

    · 击杀【克眼】：
        · 击杀1只后，开启回San光环。默认 TUNING.SANITYAURA_TINY。   inst.components.equippable.dapperness = TUNING.SANITYAURA_SMALL
        · 每击杀1只，光环升级一次。 SANITYAURA_TINY ---> SANITYAURA_SUPERHUGE
                【程序笔记】官方可选光环：
                    seg_time = 30
                    SANITYAURA_TINY = 100/(seg_time*32),
                    SANITYAURA_SMALL_TINY = 100/(seg_time*20),
                    SANITYAURA_SMALL = 100/(seg_time*8),
                    SANITYAURA_MED = 100/(seg_time*5),
                    SANITYAURA_LARGE = 100/(seg_time*2),
                    SANITYAURA_HUGE = 100/(seg_time*.5),
                    SANITYAURA_SUPERHUGE = 100/(seg_time*.25),

    · 击杀【双子魔眼】：
        · 击杀后开启【攻击回血】功能。初始：每次攻击 回血 0.5 点。
        · 每击杀1只，回血量 增加 0.3 点。最高2点（不可被二连击触发）

    · 击杀【电羊】：
        · 击杀10只带电的羊，解锁防雷。

    · 击杀【毒菌蟾蜍】：
        · 击杀1只后解锁【蟾蜍毒素】功能。攻击目标会有几率给目标上debuff ： 每秒造成 10点伤害，持续 10秒。  debuff可叠加。
        · 初始概率为10%。每击杀1只，增加5%概率。上限30%（不可被二连击触发）

    · 击杀【悲惨毒菌蟾蜍】：
        · 击杀1只后解锁【霸体】。每次被攻击都会有50%概率触发【霸体】。【霸体】期间不受到任何伤害。初始【霸体】持续时间为5s 。
        · 每击杀1只，【霸体】持续时间增加1s，概率增加2%。最多升级到10s 。60%概率。（不可被二连击触发）

    · 击杀【暗影三基佬】：
        · 每击杀一种，增加8点位面伤害，首次击杀有效，最高形态才算数。共计24点位面伤害加成。解锁位面伤害目标 ：lunar_aligned
                · 【程序笔记】：位面伤害组件：inst:AddComponent("planardamage") 
                                位面目标组件 ：inst:AddComponent("damagetypebonus") 。绑定目标位面 ：lunar_aligned / shadow_aligned
                                详情参考 亮茄剑 sword_lunarplant 和 收割者 voidcloth_scythe
    · 击杀【地下暗影三基佬】：
        ·每击杀一种，增加2点位面伤害，首次击杀有效。共计6点位面伤害加成。解锁位面伤害目标 ：lunar_aligned

    · 击杀【天体英雄】：
        · 击杀解锁【灯光】开启功能（快捷键）
        · 增加8点位面伤害，首次击杀有效。解锁位面伤害目标：shadow_aligned

    · 击杀【远古织影者】：
        · 解锁功能：【近战】攻击暗影怪有 5% 概率秒杀。每击杀一次，增加5%概率，最高50%概率。
                    【远程】击中的第一只暗影怪后弹射去附近第二只暗影怪。只弹射一次。

    · 击杀【帝王蟹】：
        · 解锁功能【雪精灵】：
            · 环绕跟随玩家。会攻击玩家攻击的目标。
            · 投掷雪球，50点伤害。2秒投掷一次。直到目标死亡或者距离过远（屏幕范围外，半径20距离）。
            · 并非生物，无法被任何形式的攻击，无法取消。。

    · 击杀【克劳斯】：
       · 击杀一只后解锁【暴击】每次攻击都会有几率造成200%伤害（可被二连击触发）
         初始几率10%每击杀一只 ， 【暴击】的几率增加5%，最高30%的几率

    · 击杀【蚁师】：
        · 击杀一只蚁师后解锁【二连击】每次攻击有几率造成两次伤害（可暴击）
        · 初始几率10%，每击杀一只，【二连击】的几率增加2%，最高20%

    · 击杀【邪天翁】
        · 击杀3只邪天翁后解锁【水上行走】轮盘开关
     
    · 击杀【远古犀牛】
        · 击杀1只犀牛后解锁【真实伤害】，攻击造成额外10点真实伤害（可被二连击触发）
        · 每击杀1只犀牛增加2点，最高20点真伤
       
    · 击杀【地下猪王】
        · 击杀1只猪王后解锁【范围伤害】，攻击造成小范围aoe伤害（可被二连击触发）
        · 初始范围4，每击杀一直增加2点范围，最高10点（2.5个地皮）
         



