<AnimDB FragDef="Animations/Mannequin/ADB/PlayerActions.xml" TagDef="Animations/Mannequin/ADB/PlayerTags.xml">
 <FragmentList>
  <melee>
   <Fragment BlendOutDuration="0.2" Tags="aa12">
    <ProcLayer>
     <Blend ExitTime="0.25" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_melee_fire_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </melee>
  <select>
   <Fragment BlendOutDuration="0.2" Tags="aa12" FragTags="first">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_generic_rifle_equip_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.4" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_krissVector_reload_charginghandle_back_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.20000005" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_krissVector_reload_charginghandle_forward_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.89999998" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_cb_radio_button_press_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="aa12">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="1.1920929e-007"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_generic_rifle_equip_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </select>
  <fire>
   <Fragment BlendOutDuration="0.2" Tags="aa12+silencer">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.043971896"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_pistol_suppresed_fire_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="aa12">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.00077056885"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_fire_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </fire>
  <reload>
   <Fragment BlendOutDuration="0.2" Tags="aa12+12gaugex8_aa12+tactical+outOfAmmo">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_1_gunReadyFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.69999999" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_2_magOut_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.21249992" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_3_backgroundFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.7875001" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_6_magHit_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.29999995" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_7_returnFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
    <ProcLayer>
     <Blend ExitTime="2" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_4_newMag_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.05" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_5_magSlideIn_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.5000002" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_krissVector_reload_charginghandle_back_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.19999981" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_krissVector_reload_charginghandle_back_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="aa12+12gaugex8_aa12+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_1_gunReadyFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.69999999" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_2_magOut_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.21249992" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_3_backgroundFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.7875001" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_6_magHit_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.29999995" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_7_returnFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
    <ProcLayer>
     <Blend ExitTime="2" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_4_newMag_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.05" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_5_magSlideIn_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="aa12+tactical">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_3_backgroundFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_6_magHit_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.29999995" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_7_returnFoley_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_4_newMag_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="0.79999995" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_aa12_reload_5_magSlideIn_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </reload>
  <change_firemode>
   <Fragment BlendOutDuration="0.2" Tags="aa12+tactical">
    <ProcLayer>
     <Blend ExitTime="0.32499999" StartTime="0" Duration="0.0033920109"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_m4a1_clip_out_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="false"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="aa12">
    <ProcLayer>
     <Blend ExitTime="0.32499999" StartTime="0" Duration="0.0009920001"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_m4a1_clip_out_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="false"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </change_firemode>
  <empty_clip>
   <Fragment BlendOutDuration="0.2" Tags="aa12">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_generic_gun_dry_fire_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </empty_clip>
  <MotionJump>
   <Fragment BlendOutDuration="0.2" Tags="aa12">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_jump_off_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </MotionJump>
  <emote>
   <Fragment BlendOutDuration="0.2" Tags="aa12+emotep_healing">
    <ProcLayer>
     <Blend ExitTime="0.85000002" StartTime="0" Duration="0.30000001"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_duct_tape_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
       <FP3PSound value="true"/>
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </emote>
 </FragmentList>
</AnimDB>
