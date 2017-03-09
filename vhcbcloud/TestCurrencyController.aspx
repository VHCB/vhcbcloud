<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestCurrencyController.aspx.cs" Inherits="vhcbcloud.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br /><br /><br />
            <asp:TextBox ID="txtAmount" runat="server" onkeyup='toCurrencyRama(value)' Width="107px"></asp:TextBox>
        &nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
        </div>
    </form>
    <script>
        var formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD',
            minimumFractionDigits: 2,
        });
        toCurrencyRama = value => {
            const digits = this.getDigitsFromValue(value);
            const digitsWithPadding = this.padDigits(digits);

            let result = this.addDecimalToNumber(digitsWithPadding);

            var inputElement = document.getElementById("txtAmount");

            inputElement.value = formatter.format(result);
        };

        showCurrency = () => {
            var inputElement = document.getElementById("txtAmount");
            alert(inputElement.value);
        }
        toCurrency = value => {
            const digits = this.getDigitsFromValue(value);
            const digitsWithPadding = this.padDigits(digits);

            let result = this.addDecimalToNumber(digitsWithPadding);

            var inputElement = document.getElementById("txtAmount");

            inputElement.value = "$" + result;
        };
        getDigitsFromValue = (value) => {
            return value.toString().replace(/\D/g, '');
        };

        padDigits = digits => {
            const desiredLength = 3;
            const actualLength = digits.length;

            if (actualLength >= desiredLength) {
                return digits;
            }

            const amountToAdd = desiredLength - actualLength;
            const padding = '0'.repeat(amountToAdd);

            return padding + digits;
        };
        addDecimalToNumber = number => {
            const centsStartingPosition = number.length - 2;
            const dollars = this.removeLeadingZeros(number.substring(0, centsStartingPosition));
            const cents = number.substring(centsStartingPosition);
            return `${dollars}.${cents}`;
        };
        removeLeadingZeros = number => number.replace(/^0+([0-9]+)/, '$1');

    </script>
</body>
</html>
