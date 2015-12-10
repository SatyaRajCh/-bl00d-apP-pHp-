<div class="small_container">
	<div class="<?= ($popup == true) ? 'details_box' : 'details_box_no_logo' ?>">
		<div class="stacked_form">
			<input type="text" id="name" placeholder="Name" />
			<input type="text" id="email" placeholder="Email" />
			<div>
				<a class="btn action_btn save_details" id="save_user_details" data-origin="<?= $origin ?>">Submit</a>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<?php if ($popup == true): ?>
		<div class="contact desktop">
			<div class="h4">Call us: <span class="fw400">1-855-331-6467</span></div>
			<div class="h4">email us: <span class="fw400">welcome@sureify.com</span></div>
		</div>
	<?php endif ?>
	<div class="clear"></div>
</div>