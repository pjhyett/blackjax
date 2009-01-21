function disable_buttons(value) {
	$('hit-button').disabled = value;
	$('stay-button').disabled = value;
}

function disable_bets(value) {
	$('deal-button').disabled = value;
	$('wager').disabled = value;
}

window.onload = function() {
	disable_bets(false);
	disable_buttons(true);
}

function check_status() {
	if(parseInt($('score').firstChild.nodeValue) >= 21){
    	$('stay_form').onsubmit();
 	}
}

function clicked() {
 	Element.show('busy');
	disable_buttons(true);
}

function deal_clicked() {
	Element.hide('result');
	Element.show('busy');
	disable_bets(true);
	disable_buttons(false);
	check_status();
}

function deal_finished() {
	Element.hide('busy');
	check_status();
}

function hit_finished() {
	Element.hide('busy');
	// have to do it manually, because you don't want to enable
	// the double button after you've hit once
	$('hit-button').disabled = false;
	$('stay-button').disabled = false;
	check_status();
}

function game_finished() {
	Element.hide('busy');
	disable_bets(false);
	disable_buttons(true);
}