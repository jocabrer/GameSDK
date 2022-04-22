<AnimDB FragDef="Animations/Mannequin/ADB/PlayerActions.xml" TagDef="Animations/Mannequin/ADB/PlayerTags.xml">
 <FragmentList>
  <select>
   <Fragment BlendOutDuration="0.2" Tags="ak74u+tactical" FragTags="first">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_first_select_tactical_ak74u"/>
    </AnimLayer>
   </Fragment>
  </select>
  <reload>
   <Fragment BlendOutDuration="0.2" Tags="ak74u+545x30+prone+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_prone_reload_dry_ak74u"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_545"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="ak74u+545x30+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_reload_dry_ak74u"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_545"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="ak74u+545x30+tactical">
    <ProcLayer>
     <Blend ExitTime="0.4000001" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_545"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.175" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="ak74u+tactical">
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_545"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.3000002" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
  </reload>
 </FragmentList>
</AnimDB>
