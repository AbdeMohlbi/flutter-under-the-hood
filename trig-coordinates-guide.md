# 📐 Unit Circle & Trigonometric Parameterization

## Definition

The **unit circle** is the set of all points $(x, y)$ such that:

$$x^2 + y^2 = 1$$

---

## Parametric Representation

Every point on the unit circle can be written as:

$$x = \cos(\theta), \quad y = \sin(\theta)$$

So we define a mapping:

$$\theta \mapsto (\cos\theta, \sin\theta)$$

---

## Geometric Interpretation

- $\theta$: angle from the positive x-axis
- $\cos(\theta)$: horizontal coordinate
- $\sin(\theta)$: vertical coordinate

---

## 🟢 Unit Circle Diagram

<svg width="300" height="300" viewBox="0 0 300 300">
<line x1="0" y1="150" x2="300" y2="150" stroke="gray" />
<line x1="150" y1="0" x2="150" y2="300" stroke="gray" />
<circle cx="150" cy="150" r="100" fill="none" stroke="black" stroke-width="2"/>
<circle cx="220.7" cy="79.3" r="4" fill="red"/>
<line x1="150" y1="150" x2="220.7" y2="79.3" stroke="blue" stroke-width="2"/>
<text x="225" y="75" font-size="12">(cosθ, sinθ)</text>
<text x="280" y="140" font-size="12">x</text>
<text x="160" y="20" font-size="12">y</text>
<circle cx="150" cy="150" r="3" fill="black"/>
<text x="155" y="165" font-size="12">(0,0)</text>
</svg>

---

## 🔺 Right Triangle Interpretation

For any angle $\theta$, we can form a triangle:

- Hypotenuse = 1
- Adjacent side = $\cos(\theta)$
- Opposite side = $\sin(\theta)$

---

## 🔻 Triangle Visualization

<svg width="300" height="300" viewBox="0 0 300 300">
<line x1="0" y1="150" x2="300" y2="150" stroke="gray" />
<line x1="150" y1="0" x2="150" y2="300" stroke="gray" />
<line x1="150" y1="150" x2="220.7" y2="150" stroke="black" stroke-width="2"/>
<line x1="220.7" y1="150" x2="220.7" y2="79.3" stroke="black" stroke-width="2"/>
<line x1="150" y1="150" x2="220.7" y2="79.3" stroke="blue" stroke-width="2"/>
<text x="175" y="165" font-size="12">cosθ</text>
<text x="230" y="120" font-size="12">sinθ</text>
<text x="175" y="110" font-size="12">1</text>
</svg>

---

## 🧩 Identity

From the triangle:

$$\cos^2(\theta) + \sin^2(\theta) = 1$$

This guarantees that all generated points lie on the unit circle.

---

## 🔄 Angle Sweep

As $\theta$ increases from $0$ to $2\pi$:

- The point moves around the entire circle
- Every possible point is covered

---

## 🔁 Parametric Motion

We can think of:

$$(x(\theta), y(\theta)) = (\cos\theta, \sin\theta)$$

as a **motion along the circle**.

---

## 🎯 Key Insight

> The unit circle is fully described by a single parameter $\theta$, and trigonometric functions convert angles into coordinates.

---

## 🧠 Summary

- Circle equation: $x^2 + y^2 = 1$
- Parametric form: $(\cos\theta, \sin\theta)$
- Geometry: projection of a rotating radius onto axes
- Motion: continuous traversal of the circle


## 📏 Scaling: Why the Radius $R$ Doesn't Matter

In trigonometry, the specific size of the circle is irrelevant to the relationships between sides. This is known as **radial invariance**.

### 1. The General Circle
For a circle with any radius $R$, the equation becomes:
$$x^2 + y^2 = R^2$$

The coordinates are simply scaled by $R$:
$$x = R\cos(\theta), \quad y = R\sin(\theta)$$

### 2. Normalization
To get back to the unit circle, we "normalize" the coordinates by dividing by the radius:
$$\left(\frac{x}{R}\right)^2 + \left(\frac{y}{R}\right)^2 = \frac{R^2}{R^2} = 1$$





