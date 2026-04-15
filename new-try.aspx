<%@ Page Language="C#" AutoEventWireup="true" CodeFile="new-try.aspx.cs" Inherits="new-try" %>



<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Diagram</title>

    <style>
        #diagramArea {
            position: relative;
            width: 900px;
            height: 550px;
            border: 1px solid #ccc;
            background: #f9f9f9;
        }

        .box {
            position: absolute;
            width: 130px;
            height: 45px;
            border: 2px solid black;
            background: #eaeaea;
            text-align: center;
            line-height: 45px;
            font-family: Arial;
            cursor: move;
            user-select: none;
            z-index: 2;
        }

        canvas {
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div id="diagramArea" runat="server">

    <canvas id="canvas" width="900" height="550"></canvas>

    <!-- LEFT -->
    <asp:Label ID="lbl1" runat="server" Text=""
        CssClass="box" Style="left:40px; top:60px;" />

    <asp:Label ID="lbl2" runat="server" Text=""
        CssClass="box" Style="left:40px; top:150px;" />

    <!-- MIDDLE -->
    <asp:Label ID="lbl3" runat="server" Text=""
        CssClass="box" Style="left:220px; top:60px;" />

    <asp:Label ID="lbl4" runat="server" Text=""
        CssClass="box" Style="left:220px; top:150px;" />

    <asp:Label ID="lbl5" runat="server" Text=""
        CssClass="box" Style="left:220px; top:240px;" />

    <asp:Label ID="lbl6" runat="server" Text=""
        CssClass="box" Style="left:220px; top:330px;" />

    <asp:Label ID="lbl7" runat="server" Text=""
        CssClass="box" Style="left:220px; top:420px;" />

    <!-- RIGHT -->
    <asp:Label ID="lbl8" runat="server" Text=""
        CssClass="box" Style="left:460px; top:130px;" />

    <asp:Label ID="lbl9" runat="server" Text=""
        CssClass="box" Style="left:460px; top:210px;" />

</div>

<script>
let selected = null, offsetX = 0, offsetY = 0;

// CONNECTIONS (your diagram structure)
const connections = [
    ["lbl1", "lbl3"],
    ["lbl1", "lbl4"],
    ["lbl2", "lbl4"],
    ["lbl4", "lbl5"],
    ["lbl4", "lbl6"],
    ["lbl4", "lbl7"],
    ["lbl4", "lbl8"],
    ["lbl4", "lbl9"]
];

// DRAG FUNCTION
document.querySelectorAll(".box").forEach(el => {
    el.addEventListener("mousedown", function (e) {
        selected = el;
        offsetX = e.offsetX;
        offsetY = e.offsetY;
    });
});

document.addEventListener("mousemove", function (e) {
    if (!selected) return;

    const parent = document.getElementById("diagramArea").getBoundingClientRect();

    selected.style.left = (e.clientX - parent.left - offsetX) + "px";
    selected.style.top = (e.clientY - parent.top - offsetY) + "px";

    drawAll();
});

document.addEventListener("mouseup", function () {
    selected = null;
});

// DRAW ELBOW CONNECTOR
function connect(ctx, fromId, toId) {
    const from = document.getElementById(fromId);
    const to = document.getElementById(toId);
    const parent = document.getElementById("diagramArea");

    const f = from.getBoundingClientRect();
    const t = to.getBoundingClientRect();
    const p = parent.getBoundingClientRect();

    const startX = f.right - p.left;
    const startY = f.top + f.height / 2 - p.top;

    const endX = t.left - p.left;
    const endY = t.top + t.height / 2 - p.top;

    const midX = startX + (endX - startX) / 2;

    ctx.beginPath();
    ctx.moveTo(startX, startY);
    ctx.lineTo(midX, startY);
    ctx.lineTo(midX, endY);
    ctx.lineTo(endX, endY);
    ctx.stroke();

    // Arrow
    ctx.beginPath();
    ctx.moveTo(endX, endY);
    ctx.lineTo(endX - 10, endY - 5);
    ctx.lineTo(endX - 10, endY + 5);
    ctx.closePath();
    ctx.fill();
}

// DRAW ALL
function drawAll() {
    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");

    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.lineWidth = 2;

    connections.forEach(c => connect(ctx, c[0], c[1]));
}

window.onload = drawAll;
</script>

</form>
</body>
</html>
