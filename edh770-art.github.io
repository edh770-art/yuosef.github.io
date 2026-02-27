import { useState, useEffect } from "react";

const S={
  async get(k){try{const r=await window.storage.get(k,false);return r?JSON.parse(r.value):null;}catch{return null;}},
  async set(k,v){try{await window.storage.set(k,JSON.stringify(v),false);}catch{}},
  async gs(k){try{const r=await window.storage.get(k,true);return r?JSON.parse(r.value):null;}catch{return null;}},
  async ss(k,v){try{await window.storage.set(k,JSON.stringify(v),true);}catch{}},
};

const T0=[{id:1,text:"שתה 8 כוסות מים 💧"},{id:2,text:"10 דקות תנועה גופנית 🏃"},{id:3,text:"קרא 5 עמודים מספר 📖"},{id:4,text:"רשום 3 דברים שאתה אסיר תודה עליהם 🙏"}];
const E0=["עשית את זה! יום מדהים! 🎉","אתה אלוף אמיתי! המשך כך! 🏆","כל צעד קטן מוביל למקום גדול! ⭐","היום הצלחת — מחר תצליח שוב! 🚀"];
const BG="linear-gradient(160deg,#0f0c29,#302b63,#24243e)";

function RegisterInput({onReg}){
  const [name,setName]=useState("");
  return <>
    <input value={name} onChange={e=>setName(e.target.value)} onKeyDown={e=>e.key==="Enter"&&name.trim()&&onReg(name.trim())} placeholder="השם שלך..." dir="rtl" autoFocus
      style={{width:"100%",boxSizing:"border-box",padding:"12px 16px",borderRadius:12,border:"1px solid rgba(255,255,255,0.2)",background:"rgba(255,255,255,0.1)",color:"#fff",fontSize:15,outline:"none",marginBottom:14,textAlign:"right"}}/>
    <button onClick={()=>name.trim()&&onReg(name.trim())} style={{width:"100%",padding:"13px",borderRadius:13,border:"none",background:name.trim()?"linear-gradient(135deg,#a78bfa,#7c3aed)":"rgba(255,255,255,0.1)",color:"#fff",fontWeight:700,fontSize:15,cursor:name.trim()?"pointer":"not-allowed"}}>בואנו! →</button>
  </>;
}

function Admin({tasks,setTasks,encs,setEncs,log,onSave,onBack}){
  const [tab,setTab]=useState("tasks");
  const [nt,setNt]=useState("");
  const [ne,setNe]=useState("");
  const [saved,setSaved]=useState(false);
  const save=async()=>{await onSave(tasks,encs);setSaved(true);setTimeout(()=>setSaved(false),2000);};
  const TB=({id,lbl})=><button onClick={()=>setTab(id)} style={{padding:"9px 16px",borderRadius:10,border:"none",cursor:"pointer",fontWeight:600,background:tab===id?"linear-gradient(135deg,#a78bfa,#7c3aed)":"rgba(255,255,255,0.08)",color:"#fff",fontSize:13}}>{lbl}</button>;
  return(
    <div style={{minHeight:"100vh",background:BG,padding:"28px 16px",fontFamily:"'Segoe UI',sans-serif"}}>
      <div style={{maxWidth:560,margin:"0 auto"}}>
        <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:24}}>
          <button onClick={onBack} style={{background:"rgba(255,255,255,0.08)",border:"none",color:"rgba(255,255,255,0.5)",padding:"8px 14px",borderRadius:10,cursor:"pointer",fontSize:13}}>← חזור</button>
          <h1 style={{color:"#fff",fontSize:20,fontWeight:800,margin:0}}>🛠 אזור שליטה</h1>
          <div style={{width:60}}/>
        </div>
        <div style={{display:"flex",gap:8,marginBottom:18,justifyContent:"center"}}>
          <TB id="tasks" lbl="📋 משימות"/><TB id="enc" lbl="💬 עידוד"/><TB id="stats" lbl="📊 סטטיסטיקות"/>
        </div>
        <div style={{background:"rgba(255,255,255,0.07)",borderRadius:20,padding:22,border:"1px solid rgba(255,255,255,0.1)"}}>
          {tab==="tasks"&&<>
            <h3 style={{color:"#fff",margin:"0 0 14px",fontSize:15}}>משימות יומיות</h3>
            <div style={{display:"flex",gap:8,marginBottom:14,direction:"rtl"}}>
              <input value={nt} onChange={e=>setNt(e.target.value)} onKeyDown={e=>{if(e.key==="Enter"&&nt.trim()){setTasks([...tasks,{id:Date.now(),text:nt.trim()}]);setNt("");}}} placeholder="משימה חדשה..." dir="rtl" style={{flex:1,padding:"9px 12px",borderRadius:10,border:"1px solid rgba(255,255,255,0.2)",background:"rgba(255,255,255,0.1)",color:"#fff",fontSize:13,outline:"none"}}/>
              <button onClick={()=>{if(!nt.trim())return;setTasks([...tasks,{id:Date.now(),text:nt.trim()}]);setNt("");}} style={{padding:"9px 14px",borderRadius:10,background:"linear-gradient(135deg,#a78bfa,#7c3aed)",border:"none",color:"#fff",fontWeight:700,cursor:"pointer"}}>+ הוסף</button>
            </div>
            {tasks.map(t=><div key={t.id} dir="rtl" style={{display:"flex",justifyContent:"space-between",alignItems:"center",padding:"9px 12px",background:"rgba(255,255,255,0.05)",borderRadius:10,marginBottom:7}}>
              <span style={{color:"#fff",fontSize:13}}>{t.text}</span>
              <button onClick={()=>setTasks(tasks.filter(x=>x.id!==t.id))} style={{background:"rgba(255,80,80,0.2)",border:"none",color:"#ff6b6b",borderRadius:6,padding:"3px 8px",cursor:"pointer",fontSize:11}}>הסר</button>
            </div>)}
          </>}
          {tab==="enc"&&<>
            <h3 style={{color:"#fff",margin:"0 0 14px",fontSize:15}}>הודעות עידוד</h3>
            <div style={{display:"flex",gap:8,marginBottom:14,direction:"rtl"}}>
              <input value={ne} onChange={e=>setNe(e.target.value)} onKeyDown={e=>{if(e.key==="Enter"&&ne.trim()){setEncs([...encs,ne.trim()]);setNe("");}}} placeholder="הודעה חדשה..." dir="rtl" style={{flex:1,padding:"9px 12px",borderRadius:10,border:"1px solid rgba(255,255,255,0.2)",background:"rgba(255,255,255,0.1)",color:"#fff",fontSize:13,outline:"none"}}/>
              <button onClick={()=>{if(!ne.trim())return;setEncs([...encs,ne.trim()]);setNe("");}} style={{padding:"9px 14px",borderRadius:10,background:"linear-gradient(135deg,#a78bfa,#7c3aed)",border:"none",color:"#fff",fontWeight:700,cursor:"pointer"}}>+ הוסף</button>
            </div>
            {encs.map((e,i)=><div key={i} dir="rtl" style={{display:"flex",justifyContent:"space-between",alignItems:"center",padding:"9px 12px",background:"rgba(255,255,255,0.05)",borderRadius:10,marginBottom:7}}>
              <span style={{color:"#fff",fontSize:13}}>{e}</span>
              <button onClick={()=>setEncs(encs.filter((_,j)=>j!==i))} style={{background:"rgba(255,80,80,0.2)",border:"none",color:"#ff6b6b",borderRadius:6,padding:"3px 8px",cursor:"pointer",fontSize:11}}>הסר</button>
            </div>)}
          </>}
          {tab==="stats"&&<>
            <h3 style={{color:"#fff",margin:"0 0 16px",fontSize:15}}>סיכום פעילות</h3>
            <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:12,marginBottom:20}}>
              {[["👥","הרשמות",log.filter(e=>e.type==="reg").length],["✅","השלמות",log.filter(e=>e.type==="done").length]].map(([ic,lb,v])=>(
                <div key={lb} style={{background:"rgba(167,139,250,0.15)",borderRadius:14,padding:"18px 14px",textAlign:"center",border:"1px solid rgba(167,139,250,0.2)"}}>
                  <div style={{fontSize:26,marginBottom:6}}>{ic}</div>
                  <div style={{color:"#fff",fontSize:28,fontWeight:800}}>{v}</div>
                  <div style={{color:"rgba(255,255,255,0.5)",fontSize:12,marginTop:4}}>{lb}</div>
                </div>
              ))}
            </div>
            {log.slice(-6).reverse().map((e,i)=>(
              <div key={i} dir="rtl" style={{display:"flex",justifyContent:"space-between",padding:"7px 10px",borderRadius:8,marginBottom:5,background:"rgba(255,255,255,0.04)"}}>
                <span style={{color:"#fff",fontSize:12}}>{e.type==="reg"?"🆕":"✅"} {e.name}</span>
                <span style={{color:"rgba(255,255,255,0.3)",fontSize:11}}>{new Date(e.date).toLocaleDateString("he-IL")}</span>
              </div>
            ))}
          </>}
        </div>
        {tab!=="stats"&&<button onClick={save} style={{display:"block",width:"100%",marginTop:14,padding:13,borderRadius:13,background:saved?"rgba(74,222,128,0.3)":"linear-gradient(135deg,#a78bfa,#7c3aed)",border:saved?"1px solid #4ade80":"none",color:"#fff",fontSize:14,fontWeight:700,cursor:"pointer"}}>
          {saved?"✓ נשמר!":"💾 שמור שינויים"}
        </button>}
      </div>
    </div>
  );
}

export default function App(){
  const [mode,setMode]=useState("landing");
  const [view,setView]=useState("init");
  const [user,setUser]=useState(null);
  const [tasks,setTasks]=useState(T0);
  const [encs,setEncs]=useState(E0);
  const [done,setDone]=useState({});
  const [showEnc,setShowEnc]=useState(false);
  const [log,setLog]=useState([]);

  useEffect(()=>{
    if(mode==="landing")return;
    (async()=>{
      const t=await S.gs("app:tasks");if(t)setTasks(t);
      const e=await S.gs("app:encs");if(e)setEncs(e);
      const l=await S.gs("app:log");if(l)setLog(l);
      if(mode==="admin"){setView("admin");return;}
      const u=await S.get("user:profile");
      if(u){setUser(u);const c=await S.get("done:"+new Date().toDateString());if(c)setDone(c);setView("tasks");}
      else setView("register");
    })();
  },[mode]);

  const back=()=>{setMode("landing");setView("init");setDone({});setShowEnc(false);};

  if(mode==="landing")return(
    <div style={{minHeight:"100vh",background:BG,display:"flex",alignItems:"center",justifyContent:"center",fontFamily:"'Segoe UI',sans-serif"}}>
      <div style={{textAlign:"center",maxWidth:340,padding:20}}>
        <div style={{fontSize:64,marginBottom:20}}>📋</div>
        <h1 style={{color:"#fff",fontSize:26,fontWeight:800,margin:"0 0 10px"}}>משימות יומיות</h1>
        <p style={{color:"rgba(255,255,255,0.5)",marginBottom:32}}>עקוב אחרי ההרגלים היומיים שלך</p>
        <div style={{display:"flex",flexDirection:"column",gap:12}}>
          <button onClick={()=>setMode("user")} style={{padding:"14px",borderRadius:14,border:"none",background:"linear-gradient(135deg,#a78bfa,#7c3aed)",color:"#fff",fontWeight:700,fontSize:15,cursor:"pointer"}}>👤 כניסה כמשתמש</button>
          <button onClick={()=>setMode("admin")} style={{padding:"14px",borderRadius:14,border:"1px solid rgba(255,255,255,0.15)",background:"rgba(255,255,255,0.08)",color:"rgba(255,255,255,0.7)",fontWeight:600,fontSize:14,cursor:"pointer"}}>🛠 אזור ניהול</button>
        </div>
      </div>
    </div>
  );

  if(view==="init")return(
    <div style={{minHeight:"100vh",background:BG,display:"flex",alignItems:"center",justifyContent:"center"}}>
      <div style={{width:40,height:40,border:"3px solid rgba(255,255,255,0.2)",borderTop:"3px solid #a78bfa",borderRadius:"50%",animation:"spin 0.8s linear infinite"}}/>
      <style>{`@keyframes spin{to{transform:rotate(360deg)}}`}</style>
    </div>
  );

  if(view==="register")return(
    <div style={{minHeight:"100vh",background:BG,display:"flex",alignItems:"center",justifyContent:"center",fontFamily:"'Segoe UI',sans-serif",padding:16}}>
      <div style={{background:"rgba(255,255,255,0.07)",backdropFilter:"blur(20px)",borderRadius:24,padding:"40px 32px",maxWidth:360,width:"100%",border:"1px solid rgba(255,255,255,0.12)",textAlign:"center"}}>
        <div style={{fontSize:48,marginBottom:16}}>✨</div>
        <h2 style={{color:"#fff",margin:"0 0 8px",fontSize:22,fontWeight:800}}>ברוך הבא!</h2>
        <p style={{color:"rgba(255,255,255,0.5)",marginBottom:24}}>הכנס את שמך כדי להתחיל</p>
        <RegisterInput onReg={async n=>{
          const u={name:n,joined:new Date().toISOString()};
          await S.set("user:profile",u);setUser(u);
          const nl=[...log,{type:"reg",name:n,date:new Date().toISOString()}];
          setLog(nl);await S.ss("app:log",nl);setView("tasks");
        }}/>
      </div>
    </div>
  );

  if(showEnc)return(
    <div style={{minHeight:"100vh",background:BG,display:"flex",alignItems:"center",justifyContent:"center",fontFamily:"'Segoe UI',sans-serif",padding:16}}>
      <div style={{textAlign:"center",maxWidth:360,background:"rgba(124,58,237,0.2)",backdropFilter:"blur(20px)",borderRadius:28,padding:"44px 36px",border:"1px solid rgba(167,139,250,0.3)"}}>
        <div style={{fontSize:64,marginBottom:20}}>🎊</div>
        <h2 style={{color:"#fff",fontSize:20,margin:"0 0 12px",lineHeight:1.5,fontWeight:800}}>{encs[Math.floor(Math.random()*encs.length)]}</h2>
        <p style={{color:"rgba(255,255,255,0.5)",marginBottom:28}}>השלמת את כל המשימות להיום! 💪</p>
        <button onClick={()=>setShowEnc(false)} style={{padding:"13px 32px",borderRadius:14,border:"none",background:"linear-gradient(135deg,#a78bfa,#7c3aed)",color:"#fff",fontWeight:700,fontSize:15,cursor:"pointer"}}>תודה! 🙏</button>
      </div>
    </div>
  );

  if(view==="tasks"){
    const dc=tasks.filter(t=>done[t.id]).length;
    const pct=tasks.length?Math.round(dc/tasks.length*100):0;
    const today=new Date().toLocaleDateString("he-IL",{weekday:"long",day:"numeric",month:"long"});
    return(
      <div style={{minHeight:"100vh",background:BG,padding:"28px 16px",fontFamily:"'Segoe UI',sans-serif"}}>
        <div style={{maxWidth:440,margin:"0 auto"}}>
          <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:24}}>
            <button onClick={back} style={{background:"rgba(255,255,255,0.08)",border:"none",color:"rgba(255,255,255,0.5)",padding:"8px 14px",borderRadius:10,cursor:"pointer",fontSize:13}}>← יציאה</button>
            <div style={{textAlign:"center"}}>
              <p style={{color:"rgba(255,255,255,0.4)",margin:0,fontSize:11}}>{today}</p>
              <h2 style={{color:"#fff",margin:0,fontSize:17,fontWeight:700}}>שלום, {user?.name} 👋</h2>
            </div>
            <div style={{width:60}}/>
          </div>
          <div style={{background:"rgba(255,255,255,0.08)",borderRadius:100,height:7,marginBottom:10,overflow:"hidden"}}>
            <div style={{height:"100%",width:pct+"%",background:"linear-gradient(90deg,#a78bfa,#7c3aed)",borderRadius:100,transition:"width 0.5s ease"}}/>
          </div>
          <p style={{color:"rgba(255,255,255,0.4)",textAlign:"center",margin:"0 0 20px",fontSize:12}}>{dc}/{tasks.length} משימות הושלמו</p>
          {tasks.map(t=>(
            <div key={t.id} onClick={async()=>{
              const nd={...done,[t.id]:!done[t.id]};
              setDone(nd);
              await S.set("done:"+new Date().toDateString(),nd);
              if(tasks.every(x=>nd[x.id])){
                const nl=[...log,{type:"done",name:user?.name,date:new Date().toISOString()}];
                setLog(nl);await S.ss("app:log",nl);setShowEnc(true);
              }
            }} dir="rtl" style={{display:"flex",alignItems:"center",gap:14,padding:"14px 18px",borderRadius:16,background:done[t.id]?"rgba(124,58,237,0.25)":"rgba(255,255,255,0.07)",border:done[t.id]?"1px solid rgba(167,139,250,0.4)":"1px solid rgba(255,255,255,0.08)",cursor:"pointer",marginBottom:10,transition:"all 0.2s"}}>
              <div style={{width:24,height:24,borderRadius:"50%",border:done[t.id]?"none":"2px solid rgba(255,255,255,0.3)",background:done[t.id]?"linear-gradient(135deg,#a78bfa,#7c3aed)":"transparent",display:"flex",alignItems:"center",justifyContent:"center",flexShrink:0}}>
                {done[t.id]&&<span style={{color:"#fff",fontSize:13}}>✓</span>}
              </div>
              <span style={{color:done[t.id]?"rgba(255,255,255,0.4)":"#fff",fontSize:15,textDecoration:done[t.id]?"line-through":"none"}}>{t.text}</span>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if(view==="admin")return <Admin tasks={tasks} setTasks={setTasks} encs={encs} setEncs={setEncs} log={log} onBack={back} onSave={async(t,e)=>{await S.ss("app:tasks",t);await S.ss("app:encs",e);}}/>;
  return null;
}
