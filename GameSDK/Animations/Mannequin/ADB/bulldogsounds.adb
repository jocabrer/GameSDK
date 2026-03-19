<AnimDB FragDef="Animations/Mannequin/ADB/PlayerActions.xml" TagDef="Animations/Mannequin/ADB/PlayerTags.xml">
 <FragmentList>
  <melee>
   <Fragment BlendOutDuration="0.2" Tags="bulldog">
    <ProcLayer>
     <Blend ExitTime="0.20000005" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_melee_fire_3p"/>
       <StopTrigger value=""/>
       <SoundObstructionType value="Ignore"/>
       <AttachmentJoint value=""/>
       <Radius value="5"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog" FragTags="first">
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
     <Blend ExitTime="1.25" StartTime="0" Duration="0"/>
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
     <Blend ExitTime="1.8499999" StartTime="0" Duration="0"/>
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
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="bulldog">
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
    </ProcLayer>
   </Fragment>
  </select>
  <fire>
   <Fragment BlendOutDuration="0.2" Tags="bulldog+silencer">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_rifle_suppresed_fire_3p"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0.2"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_bulldog_fire_3p"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog+stanagx30+tactical+outOfAmmo">
    <ProcLayer>
     <Blend ExitTime="0.69999999" StartTime="0" Duration="0"/>
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
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.7" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_m4a1_clip_in_3p"/>
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
     <Blend ExitTime="1.1999998" StartTime="0" Duration="0"/>
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
     <Blend ExitTime="0.1500001" StartTime="0" Duration="0"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog+stanagx30+tactical">
    <ProcLayer>
     <Blend ExitTime="0.69999999" StartTime="0" Duration="0"/>
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
       <dontAutoStop value="true"/>
       <Looping value="false"/>
       <AIStimulusType value="-1"/>
       <AIStimulusRadius value="0"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="1.7" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_m4a1_clip_in_3p"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog+tactical">
    <ProcLayer>
     <Blend ExitTime="1.4" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_m4a1_clip_in_3p"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog+tactical">
    <ProcLayer>
     <Blend ExitTime="0.32499999" StartTime="0" Duration="0.0009920001"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_generic_change_firemode_3p"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog">
    <ProcLayer>
     <Blend ExitTime="0.69999999" StartTime="0" Duration="0.0009920001"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_generic_change_firemode_3p"/>
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog">
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog">
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
   <Fragment BlendOutDuration="0.2" Tags="bulldog+emotep_healing">
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
