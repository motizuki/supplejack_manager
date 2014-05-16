# The majority of the Supplejack code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components licensed under the GPL or MIT licenses or otherwise publicly available. 
# See https://github.com/DigitalNZ/supplejack_manager for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

$ ->
	$('#rename-parser-template-action').click ->
	  $('#parser-template-title').hide()
	  $('#hidden-parser-template-form').show()

	$('#cancel-parser-template-delete').click ->
    $('#delete-parser-template-alert .close-reveal-modal').trigger('click')