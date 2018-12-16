<%@ Page Language="C#" AutoEventWireup="true" Theme="" CodeFile="print.aspx.cs" Inherits="print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SV Lotus Temple</title>
    <style type="text/css">
        #wrapper {
            width: 375px;
            max-width: 375px;
        }
        body {
            font-size: 7px;
        }
        h1 {
            font-family: 'Old English Text MT', Calibri, Arial;
            font-size: 4px;
        }
        h2 {
            font-size: 3px;
        }
        .auto-style1 {
            width: 400px;
        }

        .text-right {
            text-align: right;
            padding-right: 3px;
        }
        .header {
            font-weight: bold;
        }
        .serviceDate {
            width: 20%;
        }
        .serviceName {
            width: 40%;
        }
        .quantity {
            width: 10%;
        }
        .price {
            width: 30%;
        }
    </style>
    <script>
        //window.print();
    </script>
</head>
<body onload="">
    <form id="form1" runat="server">
        <div id="wrapper">
            <header>
                <div id="banner">
                    <hgroup style="float: left;">
                        <h3>
                            <span id="Span1">Sri Venkateswara Lotus Temple</span>
                        </h3>
                        <h4>
                            <span id="Span2">12501 Braddock Road, Fairfax, VA - 22030. Phone: 703-815-4850</span>
                        </h4>
                    </hgroup>
                </div>
                <div id="cleared"></div>
            </header>
            <div style="clear: both"></div>
            <article>
                <h5>Hello Vamsi Krishna Pulavarthi,</h5>
                <table>
                    <thead class="header">
                        <tr>
                            <td class="serviceDate">Service Date</td>
                            <td class="serviceName">Service Name</td>
                            <td class="quantity">Quantity</td>
                            <td class="price text-right">Price</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>09/16/2016</td>
                            <td>Archana</td>
                            <td class="text-right">1</td>
                            <td class="text-right">$ 11.00</td>
                        </tr>
                        <tr>
                            <td>09/16/2016</td>
                            <td>AbhishekamAbhishekamAbhishekam</td>
                            <td class="text-right">2</td>
                            <td class="text-right">$ 1,000,000.00</td>
                        </tr>
                    <tr>
                        <td class="header" style="padding-right: 10px">Total</td>
                        <td></td>
                        <td class="header text-right">9,999</td>
                        <td class="header text-right"><strong>$ 1,000,000.00</strong></td>
                    </tr>
                    </tbody>
                </table>
                <p>
                    <br />
                    <br />
                    Thank You<br />
                    Sri Venkateswara Lotus Temple
                </p>
            </article>
            <footer>
                <p>
                    &copy; 2016 Sri Venkateswara Lotus Temple. All rights reserved.
                </p>
            </footer>
        </div>
    </form>
</body>
</html>
