Definitions.

% TODO: Add support for currency symbols

GroupSeparator = [\.,\s]
Whitespace = [\s\t\n,]
LineBreak = [\n\r\f]
ExtWhitespace = ({Whitespace}|{LineBreak})

CurrencyChar = [A-Za-z]
CurrencyCode = ({CurrencyChar}{CurrencyChar}{CurrencyChar})

Digit = [0-9]
Value = {Digit}+({GroupSeparator}{Digit}+)?

Rules.

% value token
{Value} : {token, {value, TokenChars}}.

% currency code token
{CurrencyCode} : {token, {code, TokenChars}}.

% whitespace
{ExtWhitespace}* : {token, {whitespace}}.

% catch-all for any free-flow text
[^0-9\s]* : {token, {text, TokenChars}}.

Erlang code.
