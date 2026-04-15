<%@ Page Language="C#" AutoEventWireup="true" CodeFile="new-demo2.aspx.cs" Inherits="new_demo2" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Flow Diagram</title>

    <style>
        #area {
            position: relative;
            width: 900px;
            height: 600px;
            border: 1px solid #ccc;
            background: #fafafa;
        }

        .box {
            position: absolute;
            width: 120px;
            height: 45px;
            border: 2px solid black;
            background: #eaeaea;
            text-align: center;
            line-height: 45px;
            font-family: Arial;
        }

        canvas {
            position: absolute;
            top: 0;
            left: 0;
        }
    </style>
</head>

<body>
<form id="Form1" runat="server">

<div id="area">

<canvas id="canvas" width="900" height="600"></canvas>

<!-- LEFT SIDE -->
<asp:Label ID="main" runat="server" Text="MAIN"
    CssClass="box" Style="left:80px; top:60px;" />

<asp:Label ID="sub" runat="server" Text="SUB"
    CssClass="box" Style="left:80px; top:160px;" />

<!-- RIGHT SIDE -->
<asp:Label ID="b1" runat="server" Text="Box 1"
    CssClass="box" Style="left:500px; top:60px;" />

<asp:Label ID="b2" runat="server" Text="Box 2"
    CssClass="box" Style="left:500px; top:120px;" />

<asp:Label ID="b3" runat="server" Text="Box 3"
    CssClass="box" Style="left:500px; top:180px;" />

<asp:Label ID="b4" runat="server" Text="Box 4"
    CssClass="box" Style="left:500px; top:240px;" />

<asp:Label ID="b5" runat="server" Text="Box 5"
    CssClass="box" Style="left:500px; top:300px;" />

<asp:Label ID="b6" runat="server" Text="Box 6"
    CssClass="box" Style="left:500px; top:360px;" />

<asp:Label ID="b7" runat="server" Text="Box 7"
    CssClass="box" Style="left:500px; top:420px;" />

</div>

<script>
window.onload = function () {

    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");

    const area = document.getElementById("area").getBoundingClientRect();

    function box(id){
        let r = document.getElementById(id).getBoundingClientRect();
        return {
            x: r.left - area.left,
            y: r.top - area.top,
            w: r.width,
            h: r.height
        };
    }

    function arrow(x1,y1,x2,y2){
        ctx.beginPath();
        ctx.moveTo(x1,y1);
        ctx.lineTo(x2,y2);
        ctx.stroke();

        let a = Math.atan2(y2-y1, x2-x1);

        ctx.beginPath();
        ctx.moveTo(x2,y2);
        ctx.lineTo(x2-8*Math.cos(a-Math.PI/6), y2-8*Math.sin(a-Math.PI/6));
        ctx.lineTo(x2-8*Math.cos(a+Math.PI/6), y2-8*Math.sin(a+Math.PI/6));
        ctx.closePath();
        ctx.fill();
    }

    let M = box("main");
    let S = box("sub");

    let B = [
        box("b1"), box("b2"), box("b3"),
        box("b4"), box("b5"), box("b6"), box("b7")
    ];

    ctx.lineWidth = 2;

    // 1️⃣ MAIN → SUB (downward)
    arrow(M.x + M.w/2, M.y + M.h,
          S.x + S.w/2, S.y);

    // 2️⃣ SUB → BUS LINE (right)
    let busX = 350;
    let busTop = B[0].y;
    let busBottom = B[6].y + B[6].h/2;

    arrow(S.x + S.w, S.y + S.h/2,
          busX, S.y + S.h/2);

    // vertical bus line
    ctx.beginPath();
    ctx.moveTo(busX, busTop);
    ctx.lineTo(busX, busBottom);
    ctx.stroke();

    // 3️⃣ BUS → EACH BOX
    for(let i=0;i<B.length;i++){
        arrow(busX, B[i].y + B[i].h/2,
              B[i].x, B[i].y + B[i].h/2);
    }
};
</script>

</form>
</body>
</html>