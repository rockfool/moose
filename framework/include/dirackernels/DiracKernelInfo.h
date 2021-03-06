/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#ifndef DIRACKERNELINFO_H
#define DIRACKERNELINFO_H

#include "Moose.h"
#include "MooseArray.h"

// libMesh
#include "libmesh/elem.h"
#include "libmesh/point.h"

#include <set>
#include <map>

namespace libMesh
{
  template <class T> class NumericVector;
}

/**
 * TODO
 */
class DiracKernelInfo
{
public:
  DiracKernelInfo();
  virtual ~DiracKernelInfo();

public:
  /**
   * Adds a point source
   * @param elem Element
   * @param p Point
   */
  void addPoint(const Elem * elem, Point p);

  /// The list of elements that need distributions.
  std::set<const Elem *> _elements;

  /// The list of physical xyz Points that need to be evaluated in each element.
  std::map<const Elem *, std::set<Point> > _points;

  /**
   * Remove all of the current points and elements.
   */
  void clearPoints();
};

#endif //DIRACKERNELINFO_H
