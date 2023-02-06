### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 84c14a09-2c9e-4919-bfb1-cdf4d5a61776
using Pkg, Revise

# ╔═╡ 41ff9fda-a597-420b-93a9-b281d42acfb1
# ╠═╡ show_logs = false
Pkg.develop(path="https://github.com/GiggleLiu/PlutoMustache.jl.git")

# ╔═╡ a319ad61-9b51-412b-a186-797150a579ab
using PlutoMustache

# ╔═╡ b8d442b2-8b3d-11ed-2ac7-1f0fbfa7836d
using BenchmarkTools

# ╔═╡ cf591ae5-3b55-47c5-b7a2-6c8aefa72b7a
using LinearAlgebra: mul!

# ╔═╡ 8776764c-4483-476b-bfff-a3e779431a68
using Random

# ╔═╡ 01c33da1-b98d-42dc-8725-4afb8ae6f44f
presentmode()

# ╔═╡ 59cf2bc4-acf0-47ac-aa05-9e9a41ba783e
TableOfContents()

# ╔═╡ 5c5f6214-61c5-4532-ac05-85a43e5639cc
md"""
# About this course (10min)
## What is scientific computing?
"""

# ╔═╡ 0fe286ff-1359-4eb4-ab6c-28b231f9d56e
leftright(netimage("https://upload.wikimedia.org/wikipedia/commons/c/ce/Genegolub.jpg"), md"""
Scientific computing is the collection of tools, techniques and theories required to solve $(highlight("on a computer")) the $(highlight("mathematical models")) of problems in $(highlight("science and engineering")).

-- Gene H. Golub and James M. Ortega
"""; left=0.3)

# ╔═╡ c51b55d2-c899-421f-a633-1daa4168c6d5
md"## Textbook"

# ╔═╡ d59dce7b-5fed-45ba-9f9f-f4b93cf4b89f
leftright(md"""
$(localimage("images/textbook.jpg"))
""", md"""
#### Chapters
1. Scientific Computing
2. Systems of linear equations
3. Linear least squares
4. Eigenvalue problems
5. Nonlinear equations
6. Optimization
7. Interpolation
8. $(del("Numerical integration and differentiation"))
9. $(del("Initial value problems for ordinary differential equations"))
10. $(del("Boundary value problems for ordinary differential equations"))
11. $(del("Partial differential equations"))
12. Fast fourier transform
13. Random numbers and stochastic simulation
"""; width=660, left=0.4)

# ╔═╡ af0db2a7-41ca-4baf-89f3-4a416a062382
md"""
## This course
1. Programming
    - Understanding our computing devices
    - An introduction to modern toolkit
        - Linux operating system
        - Vim, SSH and Git
    - A programming language: Julia
2. Mathematical modeling and algorithms
    - See the textbook
3. State of the art problems
    - probabilistic modeling
    - sparsity detection (in dataset)
    - computational hard problems
"""

# ╔═╡ 26c56925-c43b-4116-9e17-16e8be2b0631
segments([3, 6, 4, 1], ["Programming", "Mathematical Modeling", "Scientific problems", "Exam"])

# ╔═╡ 4d23d2f6-eb42-4d83-ad0d-bf6ab70973fd
md" = 13 Weeks in total"

# ╔═╡ ce633741-5a25-4eda-a0f4-9050be226255
md"""
## Assessment
1. 70% by course assignment
2. 30% by final exam
## $(highlight("Our communication channel!"))
(Zulip link to be added)
## My email
Jinguo Liu

[jinguoliu@hkust-gz.edu.cn](mailto:jinguoliu@hkust-gz.edu.cn)
"""

# ╔═╡ f36e7b45-193e-4028-aae5-352711b8406d
md"# Lecture 1: Understanding our computing devices"

# ╔═╡ 72924c3a-0bbe-4d74-b2a9-60b250db4ec2
blackboard("What is inside a computer?  <br>(40min)")

# ╔═╡ 163016e4-9133-4c61-a7ac-82e41e6db234
md"## Get hardware information (Linux)"

# ╔═╡ f5ad618c-0a00-475f-b05d-97deba0faaef
@xbind show_cpuinfo CheckBox()

# ╔═╡ d5c2f523-80dd-40df-bf11-dd58cd493606
if show_cpuinfo run(`lscpu`) end

# ╔═╡ d6dca51b-978e-456e-b7c0-b658d894101d
@xbind show_meminfo CheckBox()

# ╔═╡ c0aa6f21-47d5-4f03-8b9b-a8df5c18a1b8
if show_meminfo run(`lsmem`) end

# ╔═╡ 2c92ab20-c105-4623-83c2-239462d59707
@xbind show_processinfo CheckBox()

# ╔═╡ 96c87a95-ca76-4cf5-8920-8d1f014ba47b
if show_processinfo run(`top -n 1 -b`) end

# ╔═╡ f676b4b7-fe66-4d67-827f-9943a41ddf58
md"""# Numbers"""

# ╔═╡ 080f84a2-a740-4917-acb6-d0329d7855e5
md"## Integers"

# ╔═╡ f860fd57-7cb9-47b0-84ab-30d71a812ee0
bitstring(35)

# ╔═╡ 97e5ec37-b014-49fa-8dee-a5c2a62b49df
bitstring(-35)

# ╔═╡ d168062c-2add-49ca-9a9b-b0cadad6fd60
bitstring(Int32(35))

# ╔═╡ ad14ab2b-5c29-44b7-8153-a7ffd7b781d5
typemax(Int64)

# ╔═╡ 9a79ac1a-f98f-4cdd-9dad-fb89fed6475c
typemax(Int32)

# ╔═╡ 32026c57-02be-4609-b0fa-8e03065ca4ba
md"The reason why x64 machine is becoming the main stream."

# ╔═╡ 2bd6082c-385a-4be0-a050-746a98377c94
typemax(UInt32) / 1e9

# ╔═╡ 5088b983-d8d6-4d42-8785-9127856d3fba
md"## Floating point numbers"

# ╔═╡ 01fb4139-e3c9-4d3a-b95b-cd10181ea6ac
LocalResource("float-format.png")

# ╔═╡ 9da10c5a-cc91-4663-bbe1-39c5296e7d4a
md"image source: https://en.wikipedia.org/wiki/IEEE_754"

# ╔═╡ 16dc1e93-9f16-4299-9e8e-59dff16b6fd9
md"# Estimating the computing power of your devices (20min)"

# ╔═╡ 5c13904a-505b-4fec-9e32-0ffa54a9dad8
md"""## Example 1: Matrix multiplication
```math
C_{ik} = \sum_j A_{ij} \times B_{jk}
```
"""

# ╔═╡ 13dabaa8-7310-4557-ad06-e64f566ca256
md"""
Let the matrix size be `n x n`, the peudocode for general matrix multiply (GEMM) is
```
for i=1:n
	for j=1:n
		for k=1:n
			C[i, k] = A[i, j] * B[j, k]
		end
	end
end
```
"""

# ╔═╡ 37e9697d-e2ed-4fa4-882b-5cd77586d719
md"GEMM is CPU bottlenecked"

# ╔═╡ 040fc63d-0b5c-4b33-ac8e-946573dc1c0c
@xbind matrix_size NumberField(2:3000; default=1000)

# ╔═╡ 054c57f7-22cb-4d47-a79c-7ef035586f0c
@xbind benchmark_example1 CheckBox()

# ╔═╡ 88d538e9-3757-4f87-88c5-68078aef681f
md"Loading the package for benchmarking"

# ╔═╡ ead892c7-dc0d-452b-9443-15a854683f43
md"Loading the matrix multiplication function"

# ╔═╡ 4dba5c49-7bfb-426b-8461-f062a9c4a365
if benchmark_example1
	let
		# creating random vectors with normal distribution/zero elements
		A = randn(Float64, matrix_size, matrix_size)
		B = randn(Float64, matrix_size, matrix_size)
		C = zeros(Float64, matrix_size, matrix_size)
		@benchmark mul!($C, $A, $B)
	end
end

# ╔═╡ 407219ae-51df-487e-a831-c6087428159c
md"FLOPS = the number of floating point operations / the number of seconds"

# ╔═╡ 4dcdfdd5-24e2-4fc6-86dd-335fb12b8bb4
blackboard("FLOPS for computing GEMM<br><span style='font-size: 10pt'>the number of floating point operations / the number of seconds</span>")

# ╔═╡ a87eb239-70a5-4da2-a8ce-4d3a93d976b4
md"""
## Example 2: axpy
"""

# ╔═╡ 330c3319-7954-466d-9100-f6ec19f43fcc
md"""
axpy! is memory I/O bottlenecked
"""

# ╔═╡ 9acd075f-bd77-41da-8455-e54063cbc8b4
function axpy!(a::Real, x::AbstractVector, y::AbstractVector)
	@assert length(x) == length(y) "the input size of x and y mismatch, got $(length(x)) and $(length(y))"
	@inbounds for i=1:length(x)
		y[i] += a * x[i]
	end
	return y
end

# ╔═╡ 9abf93ab-ad22-4911-b459-fa5c6f139152
@xbind axpy_vector_size NumberField(2:10000000; default=1000)

# ╔═╡ 85d0bce1-ca15-4a86-821f-87d3ec0b715c
@xbind benchmark_axpy CheckBox()

# ╔═╡ f5edd248-eb04-41d1-b435-21aa77b010b7
if benchmark_axpy
	let
		x = randn(Float64, axpy_vector_size)
		y = randn(Float64, axpy_vector_size)
		@benchmark axpy!(2.0, $x, $y)
	end
end

# ╔═╡ 0e3bfc93-33ff-487e-ac73-71922fabf660
blackboard("FLOPS for computing axpy<br><span style='font-size: 10pt'>the number of floating point operations / the number of seconds</span>")

# ╔═╡ 13ff13dd-1146-46f7-99a0-c9ee7e878931
md"## Example 3: modified axpy"

# ╔═╡ d381fcf1-3b53-49fa-a5af-1a242c83d05c
function bad_axpy!(a::Real, x::AbstractVector, y::AbstractVector, indices::AbstractVector{Int})
	@assert length(x) == length(y) == length(indices) "the input size of x and y mismatch, got $(length(x)), $(length(y)) and $(length(indices))"
	@inbounds for i in indices
		y[i] += a * x[i]
	end
	return y
end

# ╔═╡ bb0e95c9-0a73-4367-b738-f42994758ffc
md"I will show this function is latency bottlenecked"

# ╔═╡ 94016043-b913-4413-8c6a-e2b2a75dd9dd
@xbind bad_axpy_vector_size NumberField(2:10000000; default=1000)

# ╔═╡ 7fa987b4-3d97-40e0-b4e0-fd4c5759c48b
@xbind benchmark_bad_axpy CheckBox()

# ╔═╡ 5245a31a-62c3-422d-8d04-d2bdf496cbcc
if benchmark_bad_axpy
	let
		x = randn(Float64, bad_axpy_vector_size)
		y = randn(Float64, bad_axpy_vector_size)
		indices = randperm(bad_axpy_vector_size)
		@benchmark bad_axpy!(2.0, $x, $y, $indices)
	end
end

# ╔═╡ d41f8743-d3ba-437e-b7db-a9b6d1756543
blackboard("FLOPS for computing bad axpy<br><span style='font-size: 10pt'>the number of floating point operations / the number of seconds</span>")

# ╔═╡ f48ae9b5-51dd-4434-870d-4c5e73497433
md"""
# Programming on a device （30min）
"""

# ╔═╡ 9306f25a-f4f5-4b19-973d-76845a746510
md"# Software engineering (40min)"

# ╔═╡ 103bf89d-c74a-4666-bfcb-8e50695ae971


# ╔═╡ 0b157313-555b-40a5-aca0-68b17ecd7b86
md"# Primitive Data Types
"

# ╔═╡ 2e61df85-2246-4153-b8b0-174c7fc7ec8c
md"""## Numbers
Is floating point number type a field?
"""

# ╔═╡ ab90a643-8648-400f-a1ef-90b946c76471
md"# Homework (10min)
* speed of light.
* ssh to the server and estimate the computing power.
* get julia installed.
* google NPU/TPU.
"

# ╔═╡ a029e179-9c01-40f9-a23c-a5dd672740cb
md"""
#### Rules:
1. Collaboration is allowed, but you should credit your collaborator.
"""

# ╔═╡ a1ff2e4c-2416-4cb1-9df7-8e2437558287
md"# Resources"

# ╔═╡ ea04c76e-df32-4bfe-a40c-6cd9a9c9a21a
md"""## Pluto notebook using guide:
### How to play this notebook?
1. Clone this Github repo to your local host.
```bash
git clone https://github.com/GiggleLiu/ModernScientificComputing.git
```

### Controls

* Use $(kbd("Ctrl")) + $(kbd("Alt")) + $(kbd("P")) to toggle the presentation mode.
* Use $(kbd("Ctrl")) + $(kbd("→")) / $(kbd("←")) to play the previous/next slide.
"""

# ╔═╡ Cell order:
# ╠═84c14a09-2c9e-4919-bfb1-cdf4d5a61776
# ╠═41ff9fda-a597-420b-93a9-b281d42acfb1
# ╠═a319ad61-9b51-412b-a186-797150a579ab
# ╠═01c33da1-b98d-42dc-8725-4afb8ae6f44f
# ╠═59cf2bc4-acf0-47ac-aa05-9e9a41ba783e
# ╟─5c5f6214-61c5-4532-ac05-85a43e5639cc
# ╟─0fe286ff-1359-4eb4-ab6c-28b231f9d56e
# ╟─c51b55d2-c899-421f-a633-1daa4168c6d5
# ╟─d59dce7b-5fed-45ba-9f9f-f4b93cf4b89f
# ╟─af0db2a7-41ca-4baf-89f3-4a416a062382
# ╟─26c56925-c43b-4116-9e17-16e8be2b0631
# ╟─4d23d2f6-eb42-4d83-ad0d-bf6ab70973fd
# ╟─ce633741-5a25-4eda-a0f4-9050be226255
# ╟─f36e7b45-193e-4028-aae5-352711b8406d
# ╟─72924c3a-0bbe-4d74-b2a9-60b250db4ec2
# ╟─163016e4-9133-4c61-a7ac-82e41e6db234
# ╟─f5ad618c-0a00-475f-b05d-97deba0faaef
# ╠═d5c2f523-80dd-40df-bf11-dd58cd493606
# ╟─d6dca51b-978e-456e-b7c0-b658d894101d
# ╠═c0aa6f21-47d5-4f03-8b9b-a8df5c18a1b8
# ╟─2c92ab20-c105-4623-83c2-239462d59707
# ╠═96c87a95-ca76-4cf5-8920-8d1f014ba47b
# ╟─f676b4b7-fe66-4d67-827f-9943a41ddf58
# ╟─080f84a2-a740-4917-acb6-d0329d7855e5
# ╠═f860fd57-7cb9-47b0-84ab-30d71a812ee0
# ╠═97e5ec37-b014-49fa-8dee-a5c2a62b49df
# ╠═d168062c-2add-49ca-9a9b-b0cadad6fd60
# ╠═ad14ab2b-5c29-44b7-8153-a7ffd7b781d5
# ╠═9a79ac1a-f98f-4cdd-9dad-fb89fed6475c
# ╟─32026c57-02be-4609-b0fa-8e03065ca4ba
# ╠═2bd6082c-385a-4be0-a050-746a98377c94
# ╟─5088b983-d8d6-4d42-8785-9127856d3fba
# ╟─01fb4139-e3c9-4d3a-b95b-cd10181ea6ac
# ╟─9da10c5a-cc91-4663-bbe1-39c5296e7d4a
# ╟─16dc1e93-9f16-4299-9e8e-59dff16b6fd9
# ╟─5c13904a-505b-4fec-9e32-0ffa54a9dad8
# ╟─13dabaa8-7310-4557-ad06-e64f566ca256
# ╟─37e9697d-e2ed-4fa4-882b-5cd77586d719
# ╟─040fc63d-0b5c-4b33-ac8e-946573dc1c0c
# ╟─054c57f7-22cb-4d47-a79c-7ef035586f0c
# ╟─88d538e9-3757-4f87-88c5-68078aef681f
# ╠═b8d442b2-8b3d-11ed-2ac7-1f0fbfa7836d
# ╟─ead892c7-dc0d-452b-9443-15a854683f43
# ╠═cf591ae5-3b55-47c5-b7a2-6c8aefa72b7a
# ╠═4dba5c49-7bfb-426b-8461-f062a9c4a365
# ╟─407219ae-51df-487e-a831-c6087428159c
# ╟─4dcdfdd5-24e2-4fc6-86dd-335fb12b8bb4
# ╟─a87eb239-70a5-4da2-a8ce-4d3a93d976b4
# ╟─330c3319-7954-466d-9100-f6ec19f43fcc
# ╠═9acd075f-bd77-41da-8455-e54063cbc8b4
# ╟─9abf93ab-ad22-4911-b459-fa5c6f139152
# ╟─85d0bce1-ca15-4a86-821f-87d3ec0b715c
# ╠═f5edd248-eb04-41d1-b435-21aa77b010b7
# ╟─0e3bfc93-33ff-487e-ac73-71922fabf660
# ╟─13ff13dd-1146-46f7-99a0-c9ee7e878931
# ╠═d381fcf1-3b53-49fa-a5af-1a242c83d05c
# ╟─bb0e95c9-0a73-4367-b738-f42994758ffc
# ╟─94016043-b913-4413-8c6a-e2b2a75dd9dd
# ╠═7fa987b4-3d97-40e0-b4e0-fd4c5759c48b
# ╠═8776764c-4483-476b-bfff-a3e779431a68
# ╠═5245a31a-62c3-422d-8d04-d2bdf496cbcc
# ╟─d41f8743-d3ba-437e-b7db-a9b6d1756543
# ╟─f48ae9b5-51dd-4434-870d-4c5e73497433
# ╟─9306f25a-f4f5-4b19-973d-76845a746510
# ╠═103bf89d-c74a-4666-bfcb-8e50695ae971
# ╟─0b157313-555b-40a5-aca0-68b17ecd7b86
# ╟─2e61df85-2246-4153-b8b0-174c7fc7ec8c
# ╟─ab90a643-8648-400f-a1ef-90b946c76471
# ╟─a029e179-9c01-40f9-a23c-a5dd672740cb
# ╟─a1ff2e4c-2416-4cb1-9df7-8e2437558287
# ╟─ea04c76e-df32-4bfe-a40c-6cd9a9c9a21a
