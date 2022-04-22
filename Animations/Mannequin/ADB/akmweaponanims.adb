<AnimDB FragDef="Animations/Mannequin/ADB/PlayerActions.xml" TagDef="Animations/Mannequin/ADB/PlayerTags.xml">
 <FragmentList>
  <select>
   <Fragment BlendOutDuration="0.2" Tags="akm+tactical" FragTags="first">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_first_select_tactical_akm"/>
    </AnimLayer>
   </Fragment>
  </select>
  <reload>
   <Fragment BlendOutDuration="0.2" Tags="akm+762x30+prone+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_prone_reload_dry_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_762"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="akm+ext_762x75+prone+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_prone_reload_dry_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_ext_762x75"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="akm+762x30+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_reload_dry_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_762"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="akm+ext_762x75+tactical+outOfAmmo">
    <AnimLayer>
     <Blend ExitTime="0" StartTime="0" Duration="0"/>
     <Animation name="weapon_reload_dry_akm"/>
    </AnimLayer>
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_ext_762x75"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.2" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="akm+762x30+tactical">
    <ProcLayer>
     <Blend ExitTime="0.4000001" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_762"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.175" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="akm+ext_762x75+tactical">
    <ProcLayer>
     <Blend ExitTime="0.4000001" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_ext_762x75"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="3.175" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
   <Fragment BlendOutDuration="0.2" Tags="akm+tactical">
    <ProcLayer>
     <Blend ExitTime="0.5" StartTime="0" Duration="0"/>
     <Procedural type="HideAttachment">
      <ProceduralParams>
       <AttachmentName value="mag_762"/>
      </ProceduralParams>
     </Procedural>
     <Blend ExitTime="2.3000002" StartTime="0" Duration="0"/>
     <Procedural type=""/>
    </ProcLayer>
   </Fragment>
  </reload>
 </FragmentList>
</AnimDB>
