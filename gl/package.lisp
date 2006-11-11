;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; Copyright (c) 2004, Oliver Markovic <entrox@entrox.org> 
;;;   All rights reserved. 
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are met:
;;;
;;;  o Redistributions of source code must retain the above copyright notice,
;;;    this list of conditions and the following disclaimer. 
;;;  o Redistributions in binary form must reproduce the above copyright
;;;    notice, this list of conditions and the following disclaimer in the
;;;    documentation and/or other materials provided with the distribution. 
;;;  o Neither the name of the author nor the names of the contributors may be
;;;    used to endorse or promote products derived from this software without
;;;    specific prior written permission. 
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
;;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;; POSSIBILITY OF SUCH DAMAGE.

(defpackage #:cl-opengl
  (:use #:cl #:cffi)
  (:nicknames #:opengl #:gl)
  (:export
   ;; Types
   #:enum #:boolean #:bitfield #:byte #:short #:int #:sizei #:ubyte
   #:ushort #:uint #:float #:clampf #:double #:clampd #:intptr #:sizeiptr
   #:char #:handle #:ensure-float #:ensure-double
   ;; Enums
   ;; TODO: do we want to export more of these? --luis
   #:pixel-data-format #:pixel-data-type
   #:tex-image-1d-target #:tex-image-2d-target #:tex-image-3d-target
   ;; 2.5 GL Errors
   #:get-error
   #:opengl-error
   #:opengl-error.error-code
   #:check-error
   ;; 2.6 Begin/End Paradigm
   ;; 2.6.1 Begin and End
   #:begin
   #:end
   #:with-primitive
   #:with-primitives
   ;; 2.6.2 Polygon Edges
   #:edge-flag
   ;; 2.7 Vertex Specification
   #:vertex
   #:tex-coord
   #:multi-tex-coord
   #:normal
   #:fog-coord
   #:color
   #:secondary-color
   #:index
   #:vertex-attrib
   ;; 2.9 Buffer Objects
   #:bind-buffer
   #:delete-buffers
   #:gen-buffers
   #:buffer-data
   #:buffer-sub-data
   #:map-buffer
   #:unmap-buffer
   ;; 2.10 Rectangles
   #:rect
   ;; 2.11.2 Controlling the Viewport
   #:depth-range
   #:viewport
   ;; 2.11.3 Matrices
   #:matrix-mode
   #:load-matrix
   #:mult-matrix
   #:load-transpose-matrix
   #:mult-transpose-matrix
   #:rotate
   #:translate
   #:scale
   #:frustum
   #:ortho
   #:active-texture
   #:load-identity
   #:push-matrix
   #:pop-matrix
   #:with-pushed-matrix
   ;; 2.12 Clipping
   #:clip-plane
   ;; 2.13 Current Raster Position
   #:raster-pos
   #:window-pos
   ;; 2.14.1 Lighting
   #:front-face
   ;; 2.14.2 Lighting Parameter Specification
   #:material
   #:light
   #:light-model
   ;; 2.14.3 ColorMaterial
   #:color-material
   ;; 2.14.7 Flatshading
   #:shade-model
   ;; 2.15.1 Shader Objects
   #:create-shader
   #:shader-source
   #:compile-shader
   #:delete-shader
   ;; 2.15.2 Program Objects
   #:create-program
   #:attach-shader
   #:detach-shader
   #:link-program
   #:use-program
   #:delete-program
   ;; 2.15.3 Shader Variables
   #:get-active-attrib
   #:get-attrib-location
   #:bind-attrib-location
   #:get-uniform-location
   #:get-active-uniform
   #:uniformi
   #:uniformf
   #:uniform-matrix
   ;; 2.15.4 Shader Execution
   #:validate-program
   ;; 3.3 Points
   #:point-size
   #:point-parameter
   ;; 3.4 Line Segments
   #:line-width
   #:line-stipple
   ;; 3.5 Polygons
   ;; 3.5.1 Basic Polygon Rasterization
   #:cull-face
   ;; 3.5.2 Stippling
   #:polygon-stipple
   ;; 3.5.4 Options Controlling Polygon Rasterization
   #:polygon-mode 
   #:polygon-offset
   ;; 3.8.1 Texture Image Specification
   #:tex-image-1d
   #:tex-image-2d
   #:tex-image-3d
   ;; 3.8.2 Alternate Texture Image Specification Commands
   #:copy-tex-image-1d
   #:copy-tex-image-2d
   #:tex-sub-image-1d
   #:tex-sub-image-2d
   #:tex-sub-image-3d
   #:copy-tex-sub-image-1d
   #:copy-tex-sub-image-2d
   #:copy-tex-sub-image-3d
   ;; 3.8.4 Texture Parameters
   #:tex-parameter
   ;; 3.8.12 Texture Objects
   #:bind-texture
   #:delete-textures
   #:gen-textures
   #:are-textures-resident
   #:prioritize-textures
   #:texture-resident-p
   #:prioritize-texture
   ;; 3.8.13 Texture Environments and Texture Functions
   #:tex-env
   ;; 3.10 Fog
   #:fog
   ;; 5.4 Display Lists
   #:new-list
   #:end-list
   #:with-new-list
   #:call-list
   #:call-lists
   #:list-base
   #:gen-lists
   #:display-list-p
   #:delete-lists
   ;; 4.1.2 Scissor Test
   #:scissor
   ;; 4.1.3 Multisample Fragment Operations
   #:sample-coverage
   ;; 4.1.4 Alpha Test
   #:alpha-func
   ;; 4.1.5 Stencil Test
   #:stencil-func
   #:stencil-func-separate
   #:stencil-op
   #:stencil-op-separate
   ;; 4.1.6 Depth Buffer Test
   #:depth-func
   ;; 4.1.7 Occlusion Queries
   #:begin-query
   #:end-query
   #:gen-queries
   #:delete-queries
   ;; 4.1.8 Blending
   #:blend-equation
   #:blend-equation-separate
   #:blend-func
   #:blend-func-separate
   #:blend-color
   ;; 4.1.10 Logical Operation
   #:logic-op
   ;; 4.2.1 Selecting a Buffer for Writing
   #:draw-buffer
   #:draw-buffers
   ;; 4.2.2 Fine Control of Buffer Updates
   #:index-mask
   #:color-mask
   #:depth-mask
   #:stencil-mask
   #:stencil-mask-separate
   ;; 4.2.3 Clearing the Buffers
   #:clear
   #:clear-color
   #:clear-index
   #:clear-depth
   #:clear-stencil
   #:clear-accum
   ;; 4.2.4 The Accumulation Buffer
   #:accum
   ;; 4.3.2 Reading Pixels
   #:read-pixels
   #:read-buffer
   ;; 4.3.3 Copying Pixels
   #:copy-pixels
   ;; 5.1 Evaluation
   #:map1
   #:map2
   #:eval-coord-1
   #:eval-coord-2
   #:map-grid-1
   #:map-grid-2
   #:eval-mesh-1
   #:eval-mesh-2
   #:eval-point-1
   #:eval-point-2
   ;; 5.2 Selection
   #:init-names
   #:pop-name
   #:push-name
   #:load-name
   #:render-mode
   #:select-buffer
   ;; 5.3 Feedback
   #:feedback-buffer
   #:pass-through
   ;; 5.4 Display Lists
   #:new-list
   #:end-list
   #:call-list
   #:list-base
   #:gen-lists
   #:is-list
   #:delete-lists
   ;; 5.5 Flush and Finish
   #:flush
   #:finish
   ;; 5.6 Hints
   #:hint
   ;; 6.1.1 Simple Queries
   #:get-boolean
   #:get-integer
   #:get-float
   #:get-double
   #:get-enum
   #:enable
   #:disable
   #:enabledp
   ;; 6.1.11 Pointer and String Queries
   #:get-string
   #:major-version
   #:minor-version
   #:extension-present-p
   ;; 6.1.15 Saving and Restoring State
   #:push-attrib
   #:push-client-attrib
   #:pop-attrib
   #:pop-client-attrib
   ;; Extensions
   #:is-renderbuffer-ext
   #:bind-renderbuffer-ext
   #:delete-renderbuffers-ext
   #:gen-renderbuffers-ext
   #:renderbuffer-storage-ext
   #:is-framebuffer-ext
   #:bind-framebuffer-ext
   #:delete-framebuffers-ext
   #:gen-framebuffers-ext
   #:check-framebuffer-status-ext
   #:framebuffer-texture-1d-ext
   #:framebuffer-texture-2d-ext
   #:framebuffer-texture-3d-ext
   #:framebuffer-renderbuffer-ext
   #:generate-mipmap-ext
   ))

