/* Copyright 2010-2013 The MathWorks, Inc. */

window.JST = window.JST || {};

$(document).ready(function() {
    $.getScript('/help/search/plugin/underscore-min.js', function () {
        $.ajax({
            url: '/help/search/js/views/templates/suggestions.txt?ts=20140909',
            method: 'get',
            dataType: 'html',
            success: function(data) {
                var $data = $(data);
                JST['pagesuggestion'] = _.template($.trim($data.filter('#pagesuggestion').html()));
                JST['wordsuggestion'] = _.template($.trim($data.filter('#wordsuggestion').html()));
                JST['morepages'] = _.template($.trim($data.filter('#morepages').html()));
                JST['morewords'] = _.template($.trim($data.filter('#morewords').html()));
                JST['suggestionsdropdown'] = _.template($.trim($data.filter('#suggestionsdropdown').html()));
            }
        });
    });
    var searchField = getSearchField();
    searchField.keyup(function(evt) {
        validateSearchForm($(this));
        // Show suggestions whenever the search text has changed or the user hits the down arrow.
        if (evt.keyCode == 40 || isSearchFieldChanged(searchField)) {
            searchField.data('last', searchField.val());
            findSuggestions(searchField);
        }
    });

    // Hide the suggestions for any click in the document, except clicks in the search field.  Later we will also
    // exempt clicks in the suggestion area itself.
    $(document).click(function() {
        hidePopups(false);
    });
    searchField.click(function(evt) {
        validateSearchForm($(this));
        evt.stopPropagation();
    });

    $("#submitsearch").prop('disabled', true);

    $(window).resize(function() {
        var tokenizedDiv = searchField.closest('.tokenized');
        //Resize the div only if it has been tokenized, and the nuggets have been applied.
        if (tokenizedDiv.find('.tokens:first').children().length > 0) {
            tokenizedDiv.trigger('token.resize');
        }
    });
});

function validateSearchForm(searchField) {
    var val = searchField.val();
    if (val.length === 0) {
        $("#submitsearch").prop('disabled', true);
    } else {
        $("#submitsearch").prop('disabled', false);
    }
}

function isSearchFieldChanged(searchField) {
    return searchField.data('last') != searchField.val();
}

function findSuggestions(searchField) {
    var searchText = searchField.val();
    if (searchText.match(/^(\w{2,}\s*)+$/) || searchText.match(/[^\w\s]+/)) {
        var params = {'q':searchText};
        var url = getSuggestionsUrl('suggest', params);
        $.get(url, function(data) {
            displaySuggestionHtml(searchField, data);
        });
    } else {
        hidePopups(false);
    }
}

function displaySuggestionText(index, value) {
    if (value.length > 0) {
        if (index % 2 === 0) {
            return value;
        } else {
            return "<span class='suggestionhighlight'>" + value + "</span>";
        }
    } else {
        return "";
    }
}


function formatSuggestions(json) {
    var viewHelpers = {
        displaySuggestionText: displaySuggestionText,
        pageSuggestionTemplate: JST['pagesuggestion'],
        wordSuggestionTemplate: JST['wordsuggestion'],
        morePagesTemplate: JST['morepages'],
        moreWordsTemplate: JST['morewords']
    };
    _.extend(json, viewHelpers);
    return $(JST['suggestionsdropdown'](json));
}

function displaySuggestionHtml(searchField, json) {
    if ($.isEmptyObject(json)) {
        hidePopups(true);
        return;
    }
    var searchText = json.searchtext;
    var currentSearchText = searchField.data('last');
    if (searchText === currentSearchText) {
        var html = formatSuggestions(json);
        var suggestionsElt = getCleanSuggestionsElement();
        if (html.length > 0) {
            suggestionsElt.append(html);
            if (suggestionsElt.is(':hidden')) {
                showSuggestions();
            }
            suggestionsElt.attr('suggestfor', searchField.val());
        } else {
            hidePopups(false);
        }
    }                
}

function getCleanSuggestionsElement() {
    var suggestionsElt = $('#suggestions');
    suggestionsElt.data('selectionMode', 'keyboard');
    if (suggestionsElt.length == 0) {
        suggestionsElt = $('<div id="suggestions"></div>');
        $(getSearchForm()).after(suggestionsElt);
        addSuggestionHandlers(suggestionsElt);
    } else {
        suggestionsElt.empty();
    }

    var searchField = getSearchField();
    var availabePopupWidth = getPopupWidth(searchField);
    suggestionsElt.width(availabePopupWidth);
    return suggestionsElt;
}

function getPopupWidth(searchField) {
    var width = searchField.outerWidth();
    var parentDiv = searchField.closest('.input-group');
    if (parentDiv.length > 0) {
        width = parentDiv.outerWidth() - 2;
    }
    return width;
}

function addSuggestionHandlers(suggestionsElt) {
    suggestionsElt.keydown(function(evt) {
        suggestionsElt.data('selectionMode','keyboard');
        return handleKeyDown(evt);
    });
    suggestionsElt.keyup(function(evt) {
        suggestionsElt.data('selectionMode','keyboard');
        if (evt.keyCode == 13) {
            handleSelection();
        }
    });
    suggestionsElt.mousemove(function() {
        suggestionsElt.data('selectionMode','mouse');
    });
    suggestionsElt.mouseover(function(evt) {
        if (suggestionsElt.data('selectionMode') === 'mouse') {
            selectFromMouseEvent(evt);
        }
    });
    suggestionsElt.click(function(evt) {
        evt.stopPropagation();
        selectFromMouseEvent(evt);
        handleSelection();
    });
}

function selectFromMouseEvent(evt) {
    var newSelection = $(evt.target).closest('.suggestion');
    if (!newSelection.hasClass('selected-suggestion')) {
        var oldSelection = $('.selected-suggestion');
        oldSelection.removeClass('selected-suggestion');
        newSelection.addClass('selected-suggestion');
    }
}

function showSuggestions() {
    var suggestionsElt = $('#suggestions');
    suggestionsElt.slideDown('fast');
    getSearchField().unbind('keydown.searchfield-suggestions');
    getSearchField().bind('keydown.searchfield-suggestions', function(evt) {
        return handleKeyDown(evt);
    });
}

function hidePopups(focusSearchField) {
    $('#suggestions').remove();
    var sf = getSearchField();
    sf.unbind('keydown.searchfield-suggestions');
    if (focusSearchField) {
        sf.get(0).focus();
    }

    var allCats = $('#all-categories');
    if (allCats.is(':visible')) {
        allCats.hide();
    }
    var allProds = $('#all-products');
    if (allProds.is(':visible')) {
        allProds.hide();
    }
}

function handleKeyDown(evt) {
    var key = evt.keyCode? evt.keyCode : evt.charCode;
    if (key == 40) {
        // Down arrow
        selectNextSuggestion();
        return false;
    } else if (key == 38) {
        // Up arrow
        selectPrevSuggestion();
        return false;
    } else if (key == 27) {
        // Escape
        hidePopups(true);
        return false;
    } else {
        return true;
    }
}

function handleSelection() {
    var selected = $('.selected-suggestion');
    if (selected.length > 0) {
        var action = selected.attr('action');
        eval(action);
    }
}

function selectNextSuggestion() {
    var newselection = getNextSelection();
    if (newselection != null && newselection.length > 0) {
        var oldselection = $('.selected-suggestion');
        changeSelection(oldselection, newselection);
    }
}

function getNextSelection() {
    var selected = $('.selected-suggestion');
    var newselection = null;
    if (selected.length > 0) {
        newselection = selected.nextAll('.suggestion:first');
        if (newselection.length == 0) {
            // We're at the end of a section, jump to the next.
            var area = selected.closest('.suggestionarea').nextAll('.suggestionarea:first');
            return area.children('.suggestion:first');
        } else {
            return newselection;
        }
    } else {
        return $('.suggestion:first');
    }
}

function selectPrevSuggestion() {
    var newselection = getPreviousSelection();
    var oldselection = $('.selected-suggestion');
    if (newselection != null && newselection.length > 0) {
        changeSelection(oldselection, newselection);
    } else {
        oldselection.removeClass('selected-suggestion');
        getSearchField().get(0).focus();
    }
}

function getPreviousSelection() {
    var selected = $('.selected-suggestion');
    var newselection = null;
    if (selected.length > 0) {
        newselection = selected.prevAll('.suggestion:first');
        if (newselection.length == 0) {
            // We're at the beginning of a selection, jump to the previous.
            var area = selected.closest('.suggestionarea').prevAll('.suggestionarea:first');
            return area.children('.suggestion:last');
        } else {
            return newselection;
        }
    } else {
        return null;
    }
}

function changeSelection(oldselection, newselection) {
    oldselection.removeClass('selected-suggestion');
    newselection.addClass('selected-suggestion');
    getSearchField().get(0).blur();
    newselection.get(0).focus();
}

function getSearchForm() {
    return document.forms['docsearch_form'];
}

function getSearchField() {
    var searchField = $('#docsearch');
    if (searchField.length == 0) {
        searchField = $('#searchfield');
    }
    return searchField;
}

function go(page) {
    document.location = setPageSuggestionTracking(page);
}

function setPageSuggestionTracking(pageuri) {
    if (pageuri !== null && pageuri.indexOf("?") !== -1) {
        return pageuri + "&s_tid=doc_ta";
    } else {
        return pageuri + "?s_tid=doc_ta";
    }
}

function more(q, type) {
    var divId = type + 'area';
    var div = $('#' + divId);
    div.css('minHeight', div.outerHeight());
    div.css('maxHeight', div.outerHeight());

    var moreElt = $('#more' + type);
    moreElt.removeClass('suggestmore');
    moreElt.removeClass('suggestion');
    moreElt.removeClass('selected-suggestion');
    moreElt.html('<img src="/help/search/img/progress.gif" style="position:relative;top:2px;left:5px;" />');
    var params = {'q':q, 'type':type, 'start':5};
    var url = getSuggestionsUrl('suggestmore', params);
    $.get(url, function(data) {
        moreElt.remove();
        displayMoreSuggestions(divId, type, data);
    });
}

function displayMoreSuggestions(divId, type, json) {
    var template = type !== "word" ? JST['pagesuggestion'] : JST['wordsuggestion'];
    _.extend(json, {displaySuggestionText: displaySuggestionText});
    var html = $($.trim(template(json)));
    html.eq(0).addClass('selected-suggestion');
    $('#' + divId).append(html);
    $('.selected-suggestion').get(0).focus();
}

function search(q) {
    var sf = getSearchField();
    sf.val(q);
    var form = getSearchForm();
    $(form).append('<input type="hidden" name="s_tid" value="doc_ta" />');
    $(form).trigger('submit');
    form.submit();
    hidePopups(false);
}

function getSuggestionsUrl(action, params) {
    var docSet = getDocSet();
    var suggestUrl = "/help/search/" + action +  "/" + docSet;
    var lang = $('#docsearch_form').data('language');
    var release = $('#docsearch_form').data('release');
    suggestUrl += "/" + lang + "/" + release;
    params.width = getPopupWidth(getSearchField());
    return suggestUrl + '?' + $.param(params);
}

function getDocRoot() {
    if (!window.docroot) {
        window.docroot = getDocLocationInfo().docRoot;
    }
    return window.docroot;
}

function getDocSet() {
    return getDocLocationInfo().docSetName;
}

function getDocLocationInfo() {
    var pageLoc = $(location).attr("href");
    
    var release = "R2017a";
    var helpDirMappings = [{"helpDir":"/thingspeak","docSetName":"thingspeak"},{"helpDir":"/matlab-web","docSetName":"web"},{"helpDir":"","docSetName":"doccenter"}];

    for (var i = 0; i < helpDirMappings.length; i++) {
        var mapping = helpDirMappings[i];
        var urlPattern = new RegExp("/help(/releases/" + release + ")?" + mapping.helpDir + "(?=/|$)");
        var result = urlPattern.exec(pageLoc);
        if (result && result.length > 0) {
            return {"docSetName" : mapping.docSetName, "docRoot" : result[0] + "/"};
        }
    }

    return {"docSetName" : "doccenter", "docRoot" : "/help/"};
}