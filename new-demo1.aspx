<%@ Page Language="C#" AutoEventWireup="true" CodeFile="new-demo1.aspx.cs" Inherits="new_demo1" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Column Layout</title>

    <style>
        #area {
            position: relative;
            width: 700px;
            height: 500px;
            border: 1px solid #ccc;
        }

        .box {
            position: absolute;
            width: 120px;
            height: 45px;
            border: 2px solid black;
            background: #eee;
            text-align: center;
            line-height: 45px;
            font-family: Arial;
        }
    </style>
</head>

<body>
<form id="Form1" runat="server">

<div id="area">

    <!-- LEFT COLUMN -->
    <asp:Label ID="lblMain" runat="server" Text="Main Box"
        CssClass="box"
        Style="left:50px; top:60px;" />

    <asp:Label ID="lblSub" runat="server" Text="Sub Box"
        CssClass="box"
        Style="left:50px; top:140px;" />

    <!-- RIGHT COLUMN -->
    <asp:Label ID="b1" runat="server" Text="Box 1"
        CssClass="box"
        Style="left:300px; top:60px;" />

    <asp:Label ID="b2" runat="server" Text="Box 2"
        CssClass="box"
        Style="left:300px; top:140px;" />

    <asp:Label ID="b3" runat="server" Text="Box 3"
        CssClass="box"
        Style="left:300px; top:200px;" />

    <asp:Label ID="b4" runat="server" Text="Box 4"
        CssClass="box"
        Style="left:300px; top:260px;" />

    <asp:Label ID="b5" runat="server" Text="Box 5"
        CssClass="box"
        Style="left:300px; top:320px;" />

    <asp:Label ID="b6" runat="server" Text="Box 6"
        CssClass="box"
        Style="left:300px; top:380px;" />

    <asp:Label ID="b7" runat="server" Text="Box 7"
        CssClass="box"
        Style="left:300px; top:440px;" />

</div>

</form>
</body>
</html>