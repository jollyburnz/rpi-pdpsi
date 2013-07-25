// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(document).ready(function() {
	jQuery('.flash-notice').effect("highlight", {}, 2000).hide('slow');
	jQuery('.flash-error').effect("highlight", {}, 2000).hide('slow');
});
