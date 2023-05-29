Definitions.

% TODO: Add support for currency symbols

GroupSeparator = [\.,\s]
WordSeparator = {GroupSeparator}
Whitespace = [\s\t\n,]
LineBreak = [\n\r\f]
ExtWhitespace = ({Whitespace}|{LineBreak})

CurrencyChar = [A-Za-z]
CurrencyCode = ({CurrencyChar}{CurrencyChar}{CurrencyChar})

Digit = [0-9]
Value = {Digit}+({GroupSeparator}{Digit}+)*

Rules.

% value token
{Value} : {token, {value, TokenChars}}.

% currency code token
{CurrencyCode} : {token, {code, TokenChars}}.

% whitespace
{ExtWhitespace}* : skip_token.

% word separators
{WordSeparator} : {token, {word_sep}}.

% catch-all for any free-flow text
[^0-9\s\.,\n\t]* : {token, {word, TokenChars}}.

Erlang code.
