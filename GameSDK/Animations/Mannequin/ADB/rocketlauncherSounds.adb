<AnimDB FragDef="Animations/Mannequin/ADB/PlayerActions.xml" TagDef="Animations/Mannequin/ADB/PlayerTags.xml">
 <FragmentList>
  <melee>
   <Fragment BlendOutDuration="0.2" Tags="SDKRocketLauncher">
    <ProcLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Procedural type="Audio">
      <ProceduralParams>
       <StartTrigger value="Play_melee_fire_3p"/>
       <StopTrigger value=""/>
       <AttachmentJoint value=""/>
       <Radius value="0"/>
       <IsVoice value="false"/>
       <PlayFacial value="false"/>
       <SoundFlags value="0"/>
      </ProceduralParams>
     </Procedural>
    </ProcLayer>
   </Fragment>
  </melee>
    <fire>
      <Fragment BlendOutDuration="0.2" Tags="SDKRocketLauncher+silencer">
        <ProcLayer>
          <Blend ExitTime="0" StartTime="0" Duration="0.2" />
          <Procedural type="Audio">
            <ProceduralParams>
              <StartTrigger value="Play_rifle_suppresed_fire_3p" />
              <StopTrigger value="" />
              <SoundObstructionType value="Ignore" />
              <AttachmentJoint value="" />
              <Radius value="0" />
              <IsVoice value="false" />
              <PlayFacial value="false" />
              <SoundFlags value="0" />
              <FP3PSound value="true" />
              <dontAutoStop value="true" />
              <Looping value="false" />
              <AIStimulusType value="-1" />
              <AIStimulusRadius value="0" />
            </ProceduralParams>
          </Procedural>
        </ProcLayer>
      </Fragment>
      <Fragment BlendOutDuration="0.2" Tags="SDKRocketLauncher">
        <ProcLayer>
          <Blend ExitTime="0" StartTime="0" Duration="0.2" />
          <Procedural type="Audio">
            <ProceduralParams>
              <StartTrigger value="Play_acaw_fire_3p" />
              <StopTrigger value="" />
              <SoundObstructionType value="Ignore" />
              <AttachmentJoint value="" />
              <Radius value="0" />
              <IsVoice value="false" />
              <PlayFacial value="false" />
              <SoundFlags value="0" />
              <FP3PSound value="true" />
              <dontAutoStop value="true" />
              <Looping value="false" />
              <AIStimulusType value="-1" />
              <AIStimulusRadius value="0" />
            </ProceduralParams>
          </Procedural>
        </ProcLayer>
      </Fragment>
    </fire>
 </FragmentList>
</AnimDB>
