#ifndef NSMOMENTUMVISCOUSFLUX_H
#define NSMOMENTUMVISCOUSFLUX_H

#include "NSKernel.h"
#include "NSViscStressTensorDerivs.h"


// ForwardDeclarations
class NSMomentumViscousFlux;

template<>
InputParameters validParams<NSMomentumViscousFlux>();


/**
 * Derived instance of the NSViscousFluxBase class
 * for the momentum equations.
 */
class NSMomentumViscousFlux : public NSKernel
{
public:

  NSMomentumViscousFlux(const std::string & name, InputParameters parameters);

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();
  virtual Real computeQpOffDiagJacobian(unsigned int jvar);

  // Required parameter
  unsigned _component;

  // An object for computing viscous stress tensor derivatives.
  // Constructed via a reference to ourself
  NSViscStressTensorDerivs<NSMomentumViscousFlux> _vst_derivs;

  // Declare ourselves friend to the helper class.
  template <class U>
  friend class NSViscStressTensorDerivs;
};

#endif //  NSMOMENTUMVISCOUSFLUX_H
