<%@ Page Language="C#" AutoEventWireup="true" CodeFile="new-demo5.aspx.cs" Inherits="new_demo5" %>



<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<title>Responsive Diagram Final</title>

<style>
html, body {
    margin:0;
    padding:0;
    overflow:hidden;
}

#area {
    position: relative;
    width: 100vw;
    height: 100vh;
    background: #fafafa;
}

.box {
    position: absolute;
    width: 5vw;
    height: 5vh;
    border: 2px solid black;
    background: #eaeaea;
    text-align: center;
    line-height: 5vh;
    font-size: 0.7vw;
    font-family: Arial;
}

canvas {
    position:absolute;
    top:0;
    left:0;
}
</style>
</head>

<body>
<form id="Form1" runat="server">

<div id="area">

<canvas id="canvas"></canvas>

<!-- LEFT -->
<asp:Label ID="main" runat="server" Text="MAIN" CssClass="box" Style="left:5vw; top:8vh;" />
<asp:Label ID="sub"  runat="server" Text="SUB"  CssClass="box" Style="left:5vw; top:18vh;" />

<!-- RIGHT COLUMN -->
<asp:Label ID="b1" runat="server" Text="Box1" CssClass="box" Style="left:30vw; top:8vh;" />
<asp:Label ID="b2" runat="server" Text="Box2" CssClass="box" Style="left:30vw; top:16vh;" />
<asp:Label ID="b3" runat="server" Text="Box3" CssClass="box" Style="left:30vw; top:24vh;" />
<asp:Label ID="b4" runat="server" Text="Box4" CssClass="box" Style="left:30vw; top:32vh;" />
<asp:Label ID="b5" runat="server" Text="Box5" CssClass="box" Style="left:30vw; top:40vh;" />
<asp:Label ID="b6" runat="server" Text="Box6" CssClass="box" Style="left:30vw; top:48vh;" />
<asp:Label ID="b7" runat="server" Text="Box7" CssClass="box" Style="left:30vw; top:56vh;" />

<!-- HORIZONTAL CHAIN -->
<asp:Label ID="b101" runat="server" Text="101" CssClass="box" Style="left:40vw; top:8vh;" />
<asp:Label ID="b102" runat="server" Text="102" CssClass="box" Style="left:48vw; top:8vh;" />
<asp:Label ID="b103" runat="server" Text="103" CssClass="box" Style="left:56vw; top:8vh;" />
<asp:Label ID="b104" runat="server" Text="104" CssClass="box" Style="left:64vw; top:8vh;" />
<asp:Label ID="b105" runat="server" Text="105" CssClass="box" Style="left:72vw; top:8vh;" />
<asp:Label ID="b106" runat="server" Text="106" CssClass="box" Style="left:80vw; top:8vh;" />
<asp:Label ID="b107" runat="server" Text="107" CssClass="box" Style="left:88vw; top:8vh;" />


<asp:Label ID="b201" runat="server" Text="201"
    CssClass="box" Style="left:40vw; top:16vh;" />



</div>

<script>
window.onload = function(){

const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

const area = document.getElementById("area").getBoundingClientRect();

function box(id){
    let r = document.getElementById(id).getBoundingClientRect();
    return {
        x:r.left-area.left,
        y:r.top-area.top,
        w:r.width,
        h:r.height
    };
}

function arrow(x1,y1,x2,y2){
    ctx.beginPath();
    ctx.moveTo(x1,y1);
    ctx.lineTo(x2,y2);
    ctx.stroke();

    let a=Math.atan2(y2-y1,x2-x1);

    ctx.beginPath();
    ctx.moveTo(x2,y2);
    ctx.lineTo(x2-8*Math.cos(a-Math.PI/6), y2-8*Math.sin(a-Math.PI/6));
    ctx.lineTo(x2-8*Math.cos(a+Math.PI/6), y2-8*Math.sin(a+Math.PI/6));
    ctx.closePath();
    ctx.fill();
}

ctx.lineWidth=2;

// MAIN → SUB
let M=box("main"), S=box("sub");
arrow(M.x+M.w/2, M.y+M.h, S.x+S.w/2, S.y);

// BUS
let busX = window.innerWidth * 0.22;

let B = ["b1","b2","b3","b4","b5","b6","b7"].map(box);

// SUB → BUS
arrow(S.x+S.w, S.y+S.h/2, busX, S.y+S.h/2);

// vertical bus
ctx.beginPath();
ctx.moveTo(busX, B[0].y);
ctx.lineTo(busX, B[6].y + B[6].h);
ctx.stroke();

// BUS → boxes
B.forEach(b=>{
    arrow(busX, b.y+b.h/2, b.x, b.y+b.h/2);
});

// CHAIN CONNECTION
let chain=["b1","b101","b102","b103","b104","b105","b106","b107"];

for(let i=0;i<chain.length-1;i++){
    let A=box(chain[i]);
    let Bn=box(chain[i+1]);

    arrow(A.x+A.w+2, A.y+A.h/2,
          Bn.x-2, Bn.y+Bn.h/2);
}



let B2 = box("b2");
let B201 = box("b201");

arrow(
    B2.x + B2.w + 2, B2.y + B2.h/2,
    B201.x - 2, B201.y + B201.h/2
);
};
</script>

</form>
</body>
</html>