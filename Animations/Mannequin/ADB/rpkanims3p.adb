<AnimDB FragDef="Animations/Mannequin/ADB/PlayerActions.xml" TagDef="Animations/Mannequin/ADB/PlayerTags.xml">
 <FragmentList>
  <melee>
   <Fragment BlendOutDuration="0.2" Tags="rpk+bayonet+crouch">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="2d_bspace_crouch_melee_rifle"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="crouch_weaponpose_tactical_rpk" flags="Loop"/>
     <Blend ExitTime="1" StartTime="0" Duration="0"/>
     <Animation name=""/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_melee_upperbody_bayonet_a_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="2d_bspace_crouch_melee_rifle"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="crouch_weaponpose_tactical_rpk" flags="Loop"/>
     <Blend ExitTime="1" StartTime="0" Duration="0"/>
     <Animation name=""/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_melee_upperbody_a_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+bayonet">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="2D-BSpace_MoveRifleBayonetMelee"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_weaponpose_tactical_rpk" flags="Loop"/>
     <Blend ExitTime="1" StartTime="0" Duration="0"/>
     <Animation name=""/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_melee_upperbody_bayonet_a_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="2D-BSpace_MoveRifleMelee"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_weaponpose_tactical_rpk" flags="Loop"/>
     <Blend ExitTime="1" StartTime="0" Duration="0"/>
     <Animation name=""/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_melee_upperbody_a_akm"/>
    </AnimLayer>
   </Fragment>
  </melee>
  <select>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+tactical" FragTags="first">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_first_select_tactical_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical" FragTags="first">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_first_select_tactical_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical" FragTags="secondary">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_select_backl_b_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone" FragTags="primary">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.1"/>
     <Animation name="prone_select_backr_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone" FragTags="secondary">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.1"/>
     <Animation name="prone_select_backl_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_select_backr_b_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch" FragTags="secondary">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_select_backl_relaxed_b_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_select_backr_relaxed_b_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="first">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_first_select_tactical_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="secondary">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_select_backl_b_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_select_backr_b_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="secondary">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_select_backl_relaxed_b_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_select_backr_relaxed_b_rifle"/>
    </AnimLayer>
   </Fragment>
  </select>
  <fire>
   <Fragment BlendOutDuration="0.2" Tags="rpk+silencer+prone+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="prone_fire_iron_m16" flags="Sample30Hz" weight="0.80000001"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_iron_ak74u" flags="Sample30Hz"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_iron_ak74u" flags="Sample30Hz"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+silencer+prone">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="prone_fire_m16" flags="Sample30Hz" weight="0.80000001"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_ak74u" flags="Sample30Hz"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+silencer+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_iron_ak74u" flags="Sample30Hz"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_iron_ak74u" flags="Sample30Hz"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_iron_ak74u" flags="Sample30Hz"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+silencer">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_ak74u"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_fire_ak74u"/>
    </AnimLayer>
   </Fragment>
  </fire>
  <reload>
   <Fragment BlendOutDuration="0.2" Tags="rpk+762x30+prone+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="prone_reload_dry_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/762x30/762x30.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+ext_762x75+prone+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="prone_reload_dry_ext_762x75_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/ext_762x75/ext_762x75.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+762x30+prone+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="prone_reload_chambered_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.20000005" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/762x30/762x30.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+ext_762x75+prone+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="prone_reload_chambered_ext_762x75_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.20000005" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/ext_762x75/ext_762x75.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="prone_reload_fromempty_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.60000014" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/762x30/762x30.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+762x30+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_reload_dry_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/762x30/762x30.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+ext_762x75+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_reload_dry_ext_762x75_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/ext_762x75/ext_762x75.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+762x30+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_reload_chambered_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.4000001" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/762x30/762x30.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.175" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+ext_762x75+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_reload_chambered_ext_762x75_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.4000001" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/ext_762x75/ext_762x75.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.175" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_reload_fromempty_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/magazines/762x30/762x30.cgf"/>
       <AttachmentName value="left_weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.3000002" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
  </reload>
  <change_firemode>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_changefiremode_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_changefiremode_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_changefiremode_relaxed_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_changefiremode_relaxed_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_changefiremode_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_changefiremode_relaxed_akm"/>
    </AnimLayer>
   </Fragment>
  </change_firemode>
  <empty_clip>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="dryfire_pistols_generic"/>
    </AnimLayer>
   </Fragment>
  </empty_clip>
  <aimPose>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+sprint+tactical">
    <ProcLayer />
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+iron">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="crouch_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+reflex">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="crouch_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+optic">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="crouch_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="crouch_aimposes_tactical_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+iron">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="prone_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+reflex">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="prone_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+optic">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="prone_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="prone_aimposes_tactical_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+sprint">
    <ProcLayer />
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="LookPose">
      <ProceduralParams>
       <Animation value="crouch_lookposes_nw"/>
       <BlendTime value="0"/>
       <ScopeLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="LookPose">
      <ProceduralParams>
       <Animation value="prone_lookposes_nw"/>
       <BlendTime value="0"/>
       <ScopeLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="stand_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="stand_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+optic+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="stand_aimposes_iron_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+sprint+tactical">
    <ProcLayer />
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="AimPose">
      <ProceduralParams>
       <Animation value="stand_aimposes_tactical_rifle"/>
       <BlendTime value="1"/>
       <AnimationLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+sprint">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="LookPose">
      <ProceduralParams>
       <Animation value="stand_lookposes_nw"/>
       <BlendTime value="0"/>
       <ScopeLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="LookPose">
      <ProceduralParams>
       <Animation value="stand_lookposes_nw"/>
       <BlendTime value="0"/>
       <ScopeLayer value="15"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </aimPose>
  <kick>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="2D-BSpace_MoveKick"/>
     <Blend ExitTime="0.74956799" StartTime="0" Duration="0.2900002"/>
     <Animation name=""/>
    </AnimLayer>
   </Fragment>
  </kick>
  <MotionIdle>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+optic">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_idle_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+optic">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_idle_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_idle_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_idle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+optic">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_idle_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_idle_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
  </MotionIdle>
  <MotionTurn>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+optic">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="1d-bspace_pronerot90_nw" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="1d-bspace_pronerot90_nw" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="1d-bspace_pronerot90_nw" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+optic">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="1d-bspace_pronerot90_nw" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_stepRot_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="1d-bspace_pronerot90_nw" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+optic">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_stepRot_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_stepRot_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
  </MotionTurn>
  <MotionMovement>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+sprint+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_walk_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+iron">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_walk_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_run_iron_additive_rifle" flags="Loop" weight="0.75"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+reflex">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_walk_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_run_iron_additive_rifle" flags="Loop" weight="0.75"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+optic">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_walk_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_run_iron_additive_rifle" flags="Loop" weight="0.75"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_walk_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_run_additive_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+sprint">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_walk_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_walk_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron+walk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.19999997"/>
     <Animation name="stand_move_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_iron_additive_rifle" flags="Loop" speed="0.5" weight="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex+walk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.19999997"/>
     <Animation name="stand_move_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_iron_additive_rifle" flags="Loop" speed="0.5" weight="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+optic+walk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.19999997"/>
     <Animation name="stand_move_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_iron_additive_rifle" flags="Loop" speed="0.5" weight="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+walk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_move_pistol_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_additive_rifle" flags="Loop" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.19999997"/>
     <Animation name="stand_move_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_iron_additive_rifle" flags="Loop" weight="0.75"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.19999997"/>
     <Animation name="stand_move_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_iron_additive_rifle" flags="Loop" weight="0.75"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+optic+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.19999997"/>
     <Animation name="stand_move_pistol_ironsight" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_iron_additive_rifle" flags="Loop" weight="0.75"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+sprint+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_move_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_sprint_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+walk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_move_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="3D-BSpace_MoveStrafeSlope_Pistol" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_run_additive_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+sprint">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_move_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_move_nw_3p" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
  </MotionMovement>
  <MotionJump>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_iron_rifle"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_iron_rpk"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_additive_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_iron_rifle"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_additive_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+optic+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_iron_rifle"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_additive_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_rifle"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_tactical_rpk"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_additive_rifle"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_generic_start_rifle"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_relaxed_akm"/>
    </AnimLayer>
   </Fragment>
  </MotionJump>
  <MotionInAir>
   <Fragment BlendOutDuration="0.2" Tags="rpk+iron+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_fall_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0.029999971" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_iron_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="1"/>
     <Animation name="stand_jump_fall_idle_additive_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+reflex+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_fall_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0.029999971" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="1"/>
     <Animation name="stand_jump_fall_idle_additive_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+optic+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_fall_idle_iron_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0.029999971" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_reflex_akm" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="1"/>
     <Animation name="stand_jump_fall_idle_additive_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_fall_idle_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_tactical_rpk" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="1"/>
     <Animation name="stand_jump_fall_idle_additive_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_jump_fall_idle_rifle" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_relaxed_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
  </MotionInAir>
  <hitDeath>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_back+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_arm_left_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_back+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_arm_right_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_back+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_head_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_back+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_torso_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_forward+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_arm_left_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_forward+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_arm_right_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_forward+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_head_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_forward+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_torso_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_left+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_arm_left_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_left+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_arm_right_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_left+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_head_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_left+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_torso_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_right+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_arm_left_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_right+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_arm_right_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_right+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_head_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+tactical" FragTags="so_right+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_torso_tactical" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_back+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_arm_left_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_back+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_arm_right_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_back+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_head_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_back+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_back_torso_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_forward+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_arm_left_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_forward+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_arm_right_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_forward+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_head_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_forward+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_front_torso_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_left+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_arm_left_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_left+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_arm_right_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_left+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_head_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_left+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_left_torso_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_right+LeftArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_arm_left_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_right+RightArm+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_arm_right_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_right+Head+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_head_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk" FragTags="so_right+Torso+hit">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_flinch_right_torso_relaxed_rifle" speed="0.5"/>
    </AnimLayer>
   </Fragment>
  </hitDeath>
  <emote>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+emotep_crafting" FragTags="intro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_crafting_rifle_in"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+emotep_crafting" FragTags="outro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_crafting_rifle_out"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+emotep_crafting" FragTags="intro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_crafting_rifle_in"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+emotep_crafting" FragTags="outro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_crafting_rifle_out"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+emotep_handsup" FragTags="outro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_nw_emote_handsup_out"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+emotep_crafting">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_crafting_rifle_loop" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+emotep_healing">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_rifle_emote_bandage_in"/>
     <Blend ExitTime="1.3333334" StartTime="0" Duration="0.2"/>
     <Animation name="prone_rifle_emote_bandage_loop"/>
     <Blend ExitTime="-1" StartTime="0" Duration="0.2"/>
     <Animation name="prone_rifle_emote_bandage_out"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.60000002" StartTime="0" Duration="0.30000001"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/equipment/bandages/bandage/bandages.cgf"/>
       <AttachmentName value="weapon"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.4" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
    <ProcLayer>
     <Blend ExitTime="0.125" StartTime="0" Duration="0.30000001"/>
     <Procedural type="SwapAttachment">
      <ProceduralParams>
       <AttachmentNameOld value="weapon"/>
       <AttachmentNameNew value="stow_primary1_anim"/>
       <ResetOnExit value="true"/>
       <ClearOnExit value="true"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.375" StartTime="0" Duration="0.0033333302"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+emotep_crafting">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_crafting_rifle_loop" flags="Loop"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.30000001"/>
     <Procedural type="SwapAttachment">
      <ProceduralParams>
       <AttachmentNameOld value="weapon"/>
       <AttachmentNameNew value="stow_primary1_anim"/>
       <ResetOnExit value="true"/>
       <ClearOnExit value="true"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+emotep_healing">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="crouch_rifle_emote_bandage_in"/>
     <Blend ExitTime="-1" StartTime="0" Duration="0.0013334751"/>
     <Animation name="crouch_rifle_emote_bandage_loop"/>
     <Blend ExitTime="-1" StartTime="0" Duration="0"/>
     <Animation name="crouch_rifle_emote_bandage_out"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.39999986" StartTime="0" Duration="0.30000001"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/equipment/bandages/bandage/bandages.cgf"/>
       <AttachmentName value="generic_attachment"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.7699416" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
    <ProcLayer>
     <Blend ExitTime="0.125" StartTime="0" Duration="0.30000001"/>
     <Procedural type="SwapAttachment">
      <ProceduralParams>
       <AttachmentNameOld value="weapon"/>
       <AttachmentNameNew value="stow_primary1_anim"/>
       <ResetOnExit value="true"/>
       <ClearOnExit value="true"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.2249999" StartTime="0" Duration="0.0022878647"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+prone+emotep_handsup">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="prone_nw_emote_handsup_in"/>
     <Blend ExitTime="-1" StartTime="0" Duration="0"/>
     <Animation name="prone_nw_emote_handsup_loop" flags="Loop"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_akm" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+emotep_crafting" FragTags="outro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_crafting_rifle_out"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+emotep_crafting" FragTags="intro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_crafting_rifle_in"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+emotep_handsup" FragTags="outro">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_nw_emote_handsup_out"/>
    </AnimLayer>
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_weaponpose_akm"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+emotep_crafting">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_crafting_rifle_loop" flags="Loop"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.30000001"/>
     <Procedural type="SwapAttachment">
      <ProceduralParams>
       <AttachmentNameOld value="weapon"/>
       <AttachmentNameNew value="stow_primary1_anim"/>
       <ResetOnExit value="true"/>
       <ClearOnExit value="true"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+emotep_healing">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_rifle_emote_bandage_in"/>
     <Blend ExitTime="-1" StartTime="0" Duration="0.0013334751"/>
     <Animation name="stand_rifle_emote_bandage_loop"/>
     <Blend ExitTime="-1" StartTime="0" Duration="0"/>
     <Animation name="stand_rifle_emote_bandage_out"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.39999986" StartTime="0" Duration="0.30000001"/>
     <Procedural type="AttachProp">
      <ProceduralParams>
       <ObjectFilename value="objects/equipment/bandages/bandage/bandages.cgf"/>
       <AttachmentName value="generic_attachment"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.7699416" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
    <ProcLayer>
     <Blend ExitTime="0.125" StartTime="0" Duration="0.30000001"/>
     <Procedural type="SwapAttachment">
      <ProceduralParams>
       <AttachmentNameOld value="weapon"/>
       <AttachmentNameNew value="stow_primary1_anim"/>
       <ResetOnExit value="true"/>
       <ClearOnExit value="true"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.2249999" StartTime="0" Duration="0.0022878647"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+emotep_handsup">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Animation name="stand_nw_emote_handsup_in"/>
     <Blend ExitTime="-1" StartTime="0" Duration="0"/>
     <Animation name="stand_nw_emote_handsup_loop" flags="Loop"/>
    </AnimLayer>
   </Fragment>
  </emote>
  <lean>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+rightLean">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="crouch_right_lean_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+crouch+leftLean">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="crouch_left_lean_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+leftLean">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_left_lean_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="rpk+rightLean">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="stand_right_lean_rifle" flags="Loop"/>
    </AnimLayer>
   </Fragment>
  </lean>
 </FragmentList>
 <FragmentBlendList>
  <Blend from="aimPose" to="aimPose">
   <Variant from="rpk+sprint+tactical" to="rpk+tactical">
    <Fragment BlendOutDuration="0.2" selectTime="0" enterTime="0">
     <ProcLayer>
      <Blend ExitTime="0" StartTime="0" Duration="0.25" terminal="1"/>
     </ProcLayer>
    </Fragment>
   </Variant>
   <Variant from="rpk+tactical" to="rpk+sprint+tactical">
    <Fragment BlendOutDuration="0.2" selectTime="0" enterTime="0">
     <ProcLayer>
      <Blend ExitTime="0" StartTime="0" Duration="0.25" terminal="1"/>
     </ProcLayer>
    </Fragment>
   </Variant>
  </Blend>
 </FragmentBlendList>
</AnimDB>
