# see https://svelte-5-preview.vercel.app/docs/runes#$derived-by
# imba will re-render after every event (include button click) so simple code like this is ok
tag Simple
	nums = [1,2,3]
	
	def total
		result = 0
		for n in nums
			result += n
		result
	
	<self>
		<button @click=(nums.push nums.length+1)> "{nums.join('+')} = {total!}"

# same as above but demo svelte rune https://svelte.dev/blog/runes
# @observable = $state, @computed = $derived, @autorun = $effect
# see https://imba.io/docs/observable#guide-the-computed-approach
tag Rune
	@observable nums = [1,2,3]
	
	# computed return value
	@computed get total
		result = 0
		for n in nums
			result += n
		result

	# autorun make side effect
	@autorun def log
		console.log JSON.stringify(nums)

	<self>
		<button @click=(nums.push nums.length+1)> "{nums.join('+')} = {total}"

# see https://svelte-5-preview.vercel.app/docs/event-handlers
# imba use @emit to emit event then catch it at upper level
tag Pump
	size = 15
	burst = false
	
	def reset
		size = 15
		burst = false

	def inflate
		size += 5
		burst = true if size > 75

	def deflate
		size -= 5 if size > 0

	<self>
		if burst
			<button @click=reset> "new balloon"
			<span> "💥 {size}"
		else
			<div[fs:{size}px]> "🎈 {size}"
		<PumpButton @inflate=inflate @deflate=deflate>

tag PumpButton
	<self>
		<button @click.passive=emit('inflate')> "inflate"
		<button @click=emit('deflate')> "deflate"


# see more on https://component-party.dev/
tag App
	<self>
		<Simple>
		<Rune>
		<Pump>
		<div>

imba.mount <App>
