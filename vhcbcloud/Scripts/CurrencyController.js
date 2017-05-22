var formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 2,
});
toCurrencyControl = (value, id) => {
    const digits = this.getDigitsFromValue(value);
    const digitsWithPadding = this.padDigits(digits);
    let result = this.addDecimalToNumber(digitsWithPadding);
    id.val(formatter.format(result));
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

toNumericControl = (value, id) => {
    const digits = this.getDigitsFromValue(value);
    id.val(digits);
};