jQuery ->

	$('#import_pos').fileupload
		add: (e, data) ->
			data.context = $(tmpl("bar_po_upload", data.files[0]))
			$('#import_pos').append(data.context)
			data.submit()
		progress: (e, data) ->
			if data.context
				progress = parseInt(data.loaded / data.total * 100, 10);
				data.context.find('.bar').css('width', progress + '%')

	$('#import_products').fileupload
		add: (e, data) ->
			data.context = $(tmpl("bar_product_upload", data.files[0]))
			$('#import_products').append(data.context)
			data.submit()
		progress: (e, data) ->
			if data.context
				progress = parseInt(data.loaded / data.total * 100, 10);
				data.context.find('.bar').css('width', progress + '%')