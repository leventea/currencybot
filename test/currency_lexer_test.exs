defmodule CurrencyLexerTest do
  use ExUnit.Case, async: true

  test "tokenize numeric values, separators" do
    # 1 000 5,000 gets lexed as {value, "1 000 5,000"}
    # but we can't have everything i guess

    assert :currency_lexer.string('1 000 5,000, 50.12') ==
             {:ok, [value: '1 000 5,000', value: '50.12'], 1}
  end

  test "tokenize currency codes" do
    assert :currency_lexer.string('1000GBP10EUR\n1000GBPEUR') ==
             {:ok,
              [
                value: '1000',
                code: 'GBP',
                value: '10',
                code: 'EUR',
                value: '1000',
                word: 'GBPEUR'
              ], 2}
  end

  test "tokenize words" do
    assert :currency_lexer.string(
             'irrelevant words something\n\n something\n text 80.3EUR yep EUR its very true'
           ) ==
             {:ok,
              [
                word: 'irrelevant',
                word: 'words',
                word: 'something',
                word: 'something',
                word: 'text',
                value: '80.3',
                code: 'EUR',
                # it's fine if it detects 3 character words as currency codes, these will get filtered out later
                code: 'yep',
                code: 'EUR',
                code: 'its',
                word: 'very',
                word: 'true'
              ], 4}
  end
end
