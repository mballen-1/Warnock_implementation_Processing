# Warnock implementation for 3d over Proscene
This is a Warknock algorithm implementation that shows how to divide space over a 3d scene in Processing to render optimally,  using <Proscene> library by J.P. Charalambos with 'Standard Camera'
  
## Explanation
If the container (3d space to evaluate) is traversed by one plane(Triangle) it will have the color of this plane showing to the observer(Camera) this color and ignoring deeper planes (Optimal), otherwise keep dividing the 3d space in 8 parts until get this condition or find no planes inside(In this case doesn´t render anything)

## How do I use it ?
  ### Prerequisite: 
    * Processing
    * Proscene library by J.P Charalambos installed.
                  
  - I. Clone or download this repository.
  - II. Go over the Warnock3d directory
  - III. Open Warnock3d.pde file and run it.
    - III-a. Press 's' or 'S' to enable interaction.
	     Press ' ' to take a step over the Warnock algorithm and see changes (Not implemented yet)
  
## Interesting list of lectures!
  - SAMET, H. "An overview of quadtrees, octrees, and related hierarchical data structures".  Available at: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.298.9405&rep=rep1&type=pdf
  - SAMET, H. "Hierarchical Data Structures and Algorithms for Computer Graphics ". Available at: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.76.2039&rep=rep1&type=pdf

## Contact us
Developed by Miguel Ballen(migaballengal@unal.edu.co) and Camilo Neiva(jcneivaa@unal.edu.co). 
