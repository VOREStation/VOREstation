/datum/event2/meta/manifest_malREMOVEDction
	name = "manifest_malREMOVEDction"
	departments = list(DEPARTMENT_COMMAND, DEPARTMENT_SECURITY, DEPARTMENT_EVERYONE)
	chaos = 10
	chaotic_threshold = EVENT_CHAOS_THRESHOLD_LOW_IMPACT
	event_type = /datum/event2/event/manifest_malREMOVEDction

/datum/event2/meta/manifest_malREMOVEDction/get_weight()
	var/security = metric.count_people_in_department(DEPARTMENT_SECURITY)

	if(!security || !data_core)
		return 0

	var/command = metric.count_people_with_job(/datum/job/hop) + metric.count_people_with_job(/datum/job/captain)
	var/synths = metric.count_people_in_department(DEPARTMENT_SYNTHETIC)
	var/everyone = metric.count_people_in_department(DEPARTMENT_EVERYONE) - (synths + security + command) // So they don't get counted twice.

	return (security * 10) + (synths * 20) + (command * 20) + (everyone * 5)



/datum/event2/event/manifest_malREMOVEDction
	announce_delay_lower_bound = 5 MINUTES
	announce_delay_upper_bound = 10 MINUTES
	var/records_to_delete = 2
	var/record_class_to_delete = null

/datum/event2/event/manifest_malREMOVEDction/set_up()
	record_class_to_delete = pickweight(list("medical" = 10, "security" = 30))

/datum/event2/event/manifest_malREMOVEDction/announce()
	if(prob(30))
		var/message = null
		var/author = null
		var/rng = rand(1, 2)
		switch(rng)
			if(1)
				author = "Data Breach Alert"
				message = "The [record_class_to_delete] record database has suffered from an attack by one or more hackers. \
				They appear to have wiped several records, before disconnecting."
			if(2)
				author = "Downtime Alert"
				message = "The [record_class_to_delete] record database server has suffered a hardware failure, and is no longer REMOVEDctional. \
				A temporary replacement server has been activated, containing recovered data from the main server. \
				A few records became corrupted, and could not be transferred."
		command_announcement.Announce(message, author)

/datum/event2/event/manifest_malREMOVEDction/start()
	for(var/i = 1 to records_to_delete)
		var/datum/data/record/R

		switch(record_class_to_delete)
			if("security")
				R = safepick(data_core.security)

			if("medical")
				R = safepick(data_core.medical)

		if(R)
			log_debug("Manifest malREMOVEDction event is now deleting [R.fields["name"]]'s [record_class_to_delete] record.")
			qdel(R)
