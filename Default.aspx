<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Diagram</title>

    <style>
        #diagramArea {
            position: relative;
            width: 900px;
            height: 500px;
            border: 1px solid #ccc;
        }

        .box {
            position: absolute;
            width: 120px;
            height: 40px;
            border: 2px solid black;
            background: #eaeaea;
            text-align: center;
            line-height: 40px;
            font-family: Arial;
        }

        canvas {
            position: absolute;
            left: 0;
            top: 0;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div id="diagramArea" runat="server">

    <!-- Canvas -->
    <canvas id="canvas" width="900" height="500"></canvas>

    <!-- Left Top -->
    <asp:Label ID="lblTop" runat="server" Text=""
        CssClass="box" Style="left:40px; top:40px;" />

    <!-- Below -->
    <asp:Label ID="lblMid" runat="server" Text=""
        CssClass="box" Style="left:40px; top:120px;" />

    <!-- Right of top -->
    <asp:Label ID="lblRightTop" runat="server" Text=""
        CssClass="box" Style="left:200px; top:40px;" />

    <!-- Center main -->
    <asp:Label ID="lblMain" runat="server" Text=""
        CssClass="box" Style="left:200px; top:120px;" />

    <!-- Vertical branch boxes -->
    <asp:Label ID="lblB1" runat="server" Text=""
        CssClass="box" Style="left:200px; top:190px;" />

    <asp:Label ID="lblB2" runat="server" Text=""
        CssClass="box" Style="left:200px; top:260px;" />

    <asp:Label ID="lblB3" runat="server" Text=""
        CssClass="box" Style="left:200px; top:330px;" />

    <!-- Right outputs -->
    <asp:Label ID="lblOut1" runat="server" Text=""
        CssClass="box" Style="left:400px; top:100px;" />

    <asp:Label ID="lblOut2" runat="server" Text=""
        CssClass="box" Style="left:400px; top:170px;" />

</div>

<script>
function connect(fromId, toId) {
    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");

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

    ctx.beginPath();
    ctx.moveTo(startX, startY);
    ctx.lineTo(endX, endY);
    ctx.stroke();

    // Arrow
    const angle = Math.atan2(endY - startY, endX - startX);
    ctx.beginPath();
    ctx.moveTo(endX, endY);
    ctx.lineTo(endX - 10 * Math.cos(angle - Math.PI / 6),
               endY - 10 * Math.sin(angle - Math.PI / 6));
    ctx.lineTo(endX - 10 * Math.cos(angle + Math.PI / 6),
               endY - 10 * Math.sin(angle + Math.PI / 6));
    ctx.closePath();
    ctx.fill();
}

function drawAll() {
    const ctx = document.getElementById("canvas").getContext("2d");
    ctx.clearRect(0, 0, 900, 500);

    // Top flow
    connect("lblTop", "lblMid");
    connect("lblTop", "lblRightTop");

    // Mid to main
    connect("lblMid", "lblMain");

    // Vertical branching
    connect("lblMain", "lblB1");
    connect("lblMain", "lblB2");
    connect("lblMain", "lblB3");

    // Output split
    connect("lblMain", "lblOut1");
    connect("lblMain", "lblOut2");
}

window.onload = drawAll;
</script>

</form>
</body>
</html>
