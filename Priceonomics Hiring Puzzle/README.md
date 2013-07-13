<h1>Bitcoin Arbitrage</h1>

<br />

<h2>Introduction</h2>

<p>Daily trading volume in currency exchange markets often exceeds $1 trillion.  With the advent of new crypto-currencies, your knowledge of algorithms, and a good pair of sound-canceling headphones, you're convinced that there could be some profitable arbitrage opportunities to exploit.</p>

<p>Sometimes, these currency pairs drift in a way that creates arbitrage loops where you can convert through a certain sequence of currencies to return a profit in your base currency. This is referred to as an arbitrage loop. For example, you could do the following trades with $100 US and the exchange data below:</p>

<table id="rates">
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td>TO</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td><b>USD</b></td>
    <td><b>EUR</b></td>
    <td><b>JPY</b></td>
    <td><b>BTC</b></td>
  </tr>
  <tr>
    <td></td>
    <td><b>USD</b></td>
    <td>-</td>
    <td>0.7779</td>
    <td>102.4590</td>
    <td>0.0083</td>
  </tr>
   <tr>
    <td>FROM</td>
    <td><b>EUR</b></td>
    <td>1.2851</td>
    <td>-</td>
    <td>131.7110</td>
    <td>0.01125</td>
  </tr>
   <tr>
    <td></td>
    <td><b>JPY</b></td>
    <td>0.0098</td>
    <td>0.0075</td>
    <td>-</td>
    <td>0.0000811</td>
  </tr>
   <tr>
    <td></td>
    <td><b>BTC</b></td>
    <td>115.65</td>
    <td>88.8499</td>
    <td>12325.44</td>
    <td>-</td>
  </tr>
</table>

<ul>
<li>Trade $100 to &euro;77.79</li>
<li>Trade &euro;77.79 to .8751375 BTC</li>
<li>Trade .8751375 BTC for $101.20965.</li>
</ul>

<br />

<p>In this puzzle you'll be working in a market where prices are independent of supply and demand. Also, the currency exchange broker is a close friend of ours, so all trading costs are waived.</p>

<p>Your job is to write a program that efficiently finds the best arbitrage opportunities.</p>

<br />

<h2>Data Source</h2>

<p>To access real-time exchange rates, use our API:</p>

<p><a href="http://fx.priceonomics.com/v1/rates/">http://fx.priceonomics.com/v1/rates/</a></p>

<p>Output will look like the JSON below, where <code>USD_JPY</code> is the quantity of JPY that you can purchase for 1 USD.</p>

<pre>
{
USD_JPY: "95.7422091",
USD_USD: "1.0000000",
JPY_EUR: "0.0080872",
BTC_USD: "105.5641218",
...
}
</pre>

<p>These are not <em>real</em> actual market prices; we've set them algorithmically. They change every second and contain both a periodic and noise component to them. You only have to pull the data once per run of your algorithm.</p>

<h2>Task</h2>

<p>Given these exchange rates and the promise of riches, write a program (in any language of your choice) that discovers arbitrage opportunities. You can use any technique you'd like, but we like solutions that would scale with larger sets of currencies.</p>

<br />

<h2>Submitting</h2>

<p>Email your program, as well as a sample run where it makes a profit, to <a href="mailto:wong.victory@gmail.com">wong.victory.gmail.com</a>. </p>

<p>In addition, please share a little about your background and interests, the position you're interested in, and what excites you about Priceonomics in your message.</p>

