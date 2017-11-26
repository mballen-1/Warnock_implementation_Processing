# Warnock implementation for 3d over Proscene
This is a Warknock algorithm implementation that shows how to divide space over a 3d scene in Processing to render optimally,  using <Proscene> library by J.P. Charalambos with 'Standard Camera'
  
# Explanation
If the container (3d space to evaluate) is traversed by one plane(Triangle) it will have the color of this plane showing to the observer (camera) this color and ignoring deeper planes (Optimal), otherwise keep dividing the 3d space in 8 parts until get this condition or find no planes inside(In this case doesn´t render anything)

# How do I use it ?
  ## Prerequisite: 
     #### Processing
     #### Proscene library by J.P Charalambos
                  
  ### 1. Clone or download this repository.
  ### 2. Go over the Warnock3d directory
  ### 3. Open Warnock3d.pde file and run it.

# Contact us
Developed by Miguel Ballen(migaballengal@unal.edu.co) and Camilo Neiva(jcneivaa@unal.edu.co). 
